Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7EEC28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 08:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsHd5-000612-RY; Wed, 12 Mar 2025 04:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsHd4-00060c-96
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tsHd2-0007h5-PX
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741768790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=yLmnimSeJ1QTguOn2Vc00jlRK6+YVxNyJ1zqKwWKr3c=;
 b=OnzvnQz/nzaSHwKvEHtUQhhzrCUFBUWJpuOTJEsI9OC6Cgqdngt2e6lTcu0hndSbAzDwZZ
 9zhYZTspBZnwywLv7Luyc4WbO5YR2sj+DViXdyyLSBOlJ8ZEW0EVdeXzyY/HXWF82znLLQ
 8hQWWzs/QP9y3X523KqEeQ+/EEccdak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-FLSn8D7fNM2Hx-jf25MGPA-1; Wed,
 12 Mar 2025 04:39:46 -0400
X-MC-Unique: FLSn8D7fNM2Hx-jf25MGPA-1
X-Mimecast-MFC-AGG-ID: FLSn8D7fNM2Hx-jf25MGPA_1741768785
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F7A9180025B; Wed, 12 Mar 2025 08:39:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 933581956095; Wed, 12 Mar 2025 08:39:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6E51421E675E; Wed, 12 Mar 2025 09:39:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Subject: Bad error handling in loongarch's kvm_arch_init_vcpu(), need advice
Date: Wed, 12 Mar 2025 09:39:40 +0100
Message-ID: <87wmcumylv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

scripts/coccinelle/error-use-after-free.cocci led me to
target/loongarch/kvm/kvm.c:

    int kvm_arch_init_vcpu(CPUState *cs)
    {
        uint64_t val;
        int ret;
        Error *local_err = NULL;

        ret = 0;
        qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);

        if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
            brk_insn = val;
        }

        ret = kvm_cpu_check_lsx(cs, &local_err);
        if (ret < 0) {
            error_report_err(local_err);

Reporting an error, but continue anyway.  This is suspicious.

Note for later: @local_error is now non-null.

        }

        ret = kvm_cpu_check_lasx(cs, &local_err);

Passing non-null @local_error to kvm_cpu_check_lasx().  This is wrong.
When kvm_cpu_check_lasx() fails and passes &local_error to error_setg(),
error_setv()'s assertion will fail.

Two possible fixes:

1. If continuing after kvm_cpu_check_lasx() failure is correct, we need
to clear @local_error there.  Since it's not actually an error then, we
should almost certainly not use error_report_err() there.  *Maybe*
warn_report_err().

2. If continuing is wrong, we probably need to return ret.

What is the correct fix?

        if (ret < 0) {
            error_report_err(local_err);

Likewise.

        }

        ret = kvm_cpu_check_lbt(cs, &local_err);
        if (ret < 0) {
            error_report_err(local_err);

Likewise.

        }

        ret = kvm_cpu_check_pmu(cs, &local_err);
        if (ret < 0) {
            error_report_err(local_err);

Likewise.

        }

        ret = kvm_cpu_check_pv_features(cs, &local_err);
        if (ret < 0) {
            error_report_err(local_err);

Best to do the same here.

        }

        return ret;
    }


