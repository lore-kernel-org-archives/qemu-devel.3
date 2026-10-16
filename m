Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6ABCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeWB-0004qU-EN; Fri, 16 Oct 2026 05:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeW1-0004ls-Pe
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeW0-0007fi-Ab
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Al8Mglp2fdPdvnZZsmAdNzMOr4+w2njN9G9ceakAuZc=;
 b=g+RnPas7lEJtbVIBJh1MB4bhiHJVWflVOoLnMHQcKFFNb0xI4fUXBKKMJFd1cjhEGICvcp
 jT914HGn4iFZ1TCJehxIAoqhIXa3T3HSvP92AYg/l5h5PiXVl+HsVwYmJ8DdovXGkxE70U
 yddfuR/d1STLGuKu7L1BYQMjmAJbiEg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-tPNKgLD8MTqsh7cEu4Yl8w-1; Fri,
 16 Oct 2026 09:46:07 +0000
X-MC-Unique: tPNKgLD8MTqsh7cEu4Yl8w-1
X-Mimecast-MFC-AGG-ID: tPNKgLD8MTqsh7cEu4Yl8w_1792143966
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CAFF1800613; Fri, 16 Oct 2026 09:46:06 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE813418; Fri, 16 Oct 2026 09:46:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 06/19] target/riscv: implement get_dump_info sysemu op
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 anjo@rev.ng
In-Reply-To: <20261015213236.157767-7-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-7-pierrick.bouvier@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:45:51 +0400
Message-Id: <179214395193.1157317.13842824466744749517.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/mDrxIzo3ER4BZliBlcGg+LiCLORoYH70AvO4S2vfsM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0fJSxR5HRbeaOTaU1fe4QaUoes+hFDy81QnQt
 0/VEx+rvUWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatHyUgAKCRDa6OEJdZac
 5XSSD/0RV6tz1f1wG4mQ4mMFnWq/RjYSZ6Nd/9jQ3Xk4fbWFvBpY9i6xmT2h9ncAhJWTpKVmAW9
 GdPGIZ7SVP+uAlsUZsewm+KmeMGLpTw26Pvxrd9dcUgwaRf3pZwXMY4Z/c9rOgkXRwXbaTUphpT
 gWziqNyZPTRXGkEoZWxuLy/zbx+bBItD60LGzicOdCKf0b8nxb5f7Oog4KKskDWwJmgn0ouiXI/
 7ZC7U8OyYnsA/VD17/PTO1phufOvxKteiRA8jUe3DkWBVJ1On+2UZzvMKTDG/m0i057zigebmmY
 +3NSlCJtNQ2rbJqU8HforEh3h51xEANkH00dbp5IdI1oTkq3kOYojqwHBlvP4S4+4hHsHUmweyQ
 Fd44BhkqlZEACrTMZ9j8RL/5GzDcWF3eUdjnfTzP/OOC5nVOjxXB1vSz2IBJJUI+02AnmA4Jooi
 COGb6orKR/BTtvjmCsEU15314C8r94GMxqIa000DqvL/vzGGXEaGfHiV7raZVsITalzINcDeRyC
 7kpwo+5tcq7OiVByFibFNM3ancpgg89qtoIoRyomezVxtQ/z1lcAllMi6Zuc8IK+SZydc99wXpy
 TliK4HM9lSWi9lcsUSuE9GfSJwpFu6JBX23aEszL92JaPzfW+8lrm37JHM36Hm+ywucF3ltKpL2
 bnxZtLl4rAfme8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

> For now, we keep the global cpu_get_dump_info symbol defined.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Message-ID: <20261015213236.157767-7-pierrick.bouvier@oss.qualcomm.com>
>
> diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
> index 12b687990702..ac9e49646605 100644
> --- a/target/riscv/arch_dump.c
> +++ b/target/riscv/arch_dump.c
> @@ -20,6 +20,7 @@
>  #include "cpu.h"
>  #include "elf.h"
>  #include "system/dump.h"
> +#include "internals.h"
>  
>  /* struct user_regs_struct from arch/riscv/include/uapi/asm/ptrace.h */
>  struct riscv64_user_regs {
> @@ -161,17 +162,11 @@ int riscv_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>      return ret;
>  }
>  
> -int cpu_get_dump_info(ArchDumpInfo *info,
> -                      const GuestPhysBlockList *guest_phys_blocks)
> +int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
> +                        const GuestPhysBlockList *guest_phys_blocks)
>  {
> -    RISCVCPU *cpu;
> -    CPURISCVState *env;
> -
> -    if (first_cpu == NULL) {
> -        return -1;
> -    }
> -    cpu = RISCV_CPU(first_cpu);
> -    env = &cpu->env;
> +    RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;

can it be const like other archs?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


