Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F00C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZUK-00021a-6Z; Wed, 10 Jul 2024 11:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sRZUI-0001yY-Bc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sRZUG-0003a7-5j
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720626246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NH0YphbLJIChi/3SkiNAIIFjNtwVxbllg4kSIpTdYuo=;
 b=EIcoGfRy3leD2pJHL5X+e2PuDKeUxIHVSBvudUpuAeuu2+2yR9h8JbXiQky0UZwuJq273k
 jnI2TszlXq7mxCNBds16sf6IrAri7Dkli3fpkKJqKwIihakod8LlxFwsDfToa/sDS/oBLb
 B4vwCFPlNt7tNRVgvlrPQnjYOyTs59Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-X00OlGg2Ouajqc9bsQ_Q5Q-1; Wed,
 10 Jul 2024 11:42:54 -0400
X-MC-Unique: X00OlGg2Ouajqc9bsQ_Q5Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAFF019560AB; Wed, 10 Jul 2024 15:42:50 +0000 (UTC)
Received: from localhost (unknown [10.39.194.152])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 354363000182; Wed, 10 Jul 2024 15:42:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 darren@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: Re: [PATCH] arm/kvm: add support for MTE
In-Reply-To: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 10 Jul 2024 17:42:45 +0200
Message-ID: <875xtdcky2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 08 2024, Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:

> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable
> the capability.
>
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
>
> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
> which broke TCG since it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM.

So, the main difference to my original patch is that we don't end up
with MTE in the max model if we didn't configure tag memory, but the
rest of the behaviour stays the same?

>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>

(...)

> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    static bool tried_to_enable;
> +    static bool succeeded_to_enable;
> +    Error *mte_migration_blocker = NULL;
> +    int ret;
> +
> +    if (!tried_to_enable) {
> +        /*
> +         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
> +         * sense), and we only want a single migration blocker as well.
> +         */
> +        tried_to_enable = true;
> +
> +        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
> +            return;
> +        }
> +
> +        /* TODO: Migration is not supported with MTE enabled */

Do you have a plan for enabling migration in the future? From what I
remember, pre-copy support should be doable within QEMU (with a similar
approach to e.g. s390 skey), but post-copy would need a kernel API
extension to support getting additional data while faulting in a page.

> +        error_setg(&mte_migration_blocker,
> +                   "Live migration disabled due to MTE enabled");
> +        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
> +            error_free(mte_migration_blocker);
> +            return;
> +        }
> +        succeeded_to_enable = true;
> +    }
> +    if (succeeded_to_enable) {
> +        object_property_set_bool(cpuobj, "has_mte", true, NULL);
> +    }
> +}


