Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D48C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiXi2-0003ur-JC; Thu, 13 Feb 2025 06:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiXhz-0003ue-Tp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiXhx-0005yq-VC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739447318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=viO7qmnlWrZt2ER4ZxRJLY7XSgD4+ZaaxRdGbrtL1yw=;
 b=XdiZMl+zYQqBiflvclnjDmV+Bc9Ft1tKwCq5D9Hnam/hJzCM18SPYoW41dnSKiAToI0SPY
 /IeNlv8+5cXR/YvQRC6+S+Bjpo5KdR3NimW/S7B1cvEjiW/tJ9OvNnPbqmYCue68SFzJ8J
 HaBA0JLnDPIvRyHEswnB5Vjl6BzF97E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-1Sohwg3pPKSfvEck7bkmiw-1; Thu,
 13 Feb 2025 06:48:35 -0500
X-MC-Unique: 1Sohwg3pPKSfvEck7bkmiw-1
X-Mimecast-MFC-AGG-ID: 1Sohwg3pPKSfvEck7bkmiw_1739447314
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDB1F18EB2C3; Thu, 13 Feb 2025 11:48:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD84D300018D; Thu, 13 Feb 2025 11:48:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1EDBD21E6A28; Thu, 13 Feb 2025 12:48:30 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: gaosong <gaosong@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>,  QEMU devel <qemu-devel@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] target/loongarch: Add full type support for
 query-cpu-model-expansion
In-Reply-To: <30c1c330-32d1-fa36-c0ca-670c94a06736@loongson.cn>
 (gaosong@loongson.cn's message of "Thu, 13 Feb 2025 18:07:06 +0800")
References: <20250213091626.3650603-1-maobibo@loongson.cn>
 <30c1c330-32d1-fa36-c0ca-670c94a06736@loongson.cn>
Date: Thu, 13 Feb 2025 12:48:30 +0100
Message-ID: <87a5aqhxpt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

gaosong <gaosong@loongson.cn> writes:

> Cc: Markus
>
> hi, Markus
>
> What is the difference between CPU_MODEL_EXPANSION_TYPE_STATIC and 
> CPU_MODEL_EXPANSION_TYPE_FULL?

I don't know :)

Here's the documentation:

    ##
    # @CpuModelExpansionType:
    #
    # An enumeration of CPU model expansion types.
    #
    # @static: Expand to a static CPU model, a combination of a static
    #     base model name and property delta changes.  As the static base
    #     model will never change, the expanded CPU model will be the
    #     same, independent of QEMU version, machine type, machine
    #     options, and accelerator options.  Therefore, the resulting
    #     model can be used by tooling without having to specify a
    #     compatibility machine - e.g. when displaying the "host" model.
    #     The @static CPU models are migration-safe.
    #
    # @full: Expand all properties.  The produced model is not guaranteed
    #     to be migration-safe, but allows tooling to get an insight and
    #     work with model details.
    #
    # .. note:: When a non-migration-safe CPU model is expanded in static
    #    mode, some features enabled by the CPU model may be omitted,
    #    because they can't be implemented by a static CPU model
    #    definition (e.g. cache info passthrough and PMU passthrough in
    #    x86).  If you need an accurate representation of the features
    #    enabled by a non-migration-safe CPU model, use @full.  If you
    #    need a static representation that will keep ABI compatibility
    #    even when changing QEMU version or machine-type, use @static (but
    #    keep in mind that some features may be omitted).
    #
    # Since: 2.8
    ##

If you have further questions, David Hildenbrand or Eduardo Habkost
(cc'ed) might be able to help.


