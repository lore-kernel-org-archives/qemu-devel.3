Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22435CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHm4-0007kI-Gp; Thu, 15 Oct 2026 05:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHHm1-0007iq-Oy
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHHlz-0005UQ-Ow
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 05:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792056554;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=x/dxeng4eOW0e5HyQvSWqbwVVzdJY7sjj6J/J5iYM/M=;
 b=R1h8nynt3cY0frheS9Dio71BajLfwDOP+OSAC5mI0ZmASyZAW/lHPibIVtUDUUU1IR0Sbq
 mbpLC2YRMoNAaUfPGtTq9crrhs83cMZglBuNl+DX03q8ssZVxkoWnLoVIMmEzAFSVo9LBq
 lAl0UGFDNtznTxYttuYpOIxLNGz9iYA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-ZFzJAW-PNC-3A3lNN2J7oA-1; Thu,
 15 Oct 2026 09:29:10 +0000
X-MC-Unique: ZFzJAW-PNC-3A3lNN2J7oA-1
X-Mimecast-MFC-AGG-ID: ZFzJAW-PNC-3A3lNN2J7oA_1792056546
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6297818011DC; Thu, 15 Oct 2026 09:29:04 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02723180057F; Thu, 15 Oct 2026 09:28:51 +0000 (UTC)
Date: Thu, 15 Oct 2026 10:28:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@kernel.org>,
 Glenn Miles <milesg@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Song Gao <17746591750@163.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eric Farman <farman@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Chao Liu <chao.liu@processmission.com>, qemu-s390x@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: Re: [PATCH] target-info: dispatch CPU QMP, dump, monitor, and Angel
 semihosting
Message-ID: <atCc0GPHiZo2WlNM@redhat.com>
References: <20261015044104.879-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015044104.879-1-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 15, 2026 at 12:41:02PM +0800, Yonggang Luo wrote:
> Put query-cpu-definitions, dump notes, monitor, and Angel semihosting on
> TargetOps[SYS_EMU_TARGET__MAX] and look up by target_arch().
> Keep the table in target-ops.c and with a stub
> 
> - Register with a QEMU_ARCH_* bitmask so shared base-arch objects
>   can fill both slots (e.g. QEMU_ARCH_ARM is ARM|AARCH64).
> - TARGET_INFO_CPU_OP is type_init. A NULL member means no handler.
> - Drop stubs/qmp-cpu.c
>        stubs/hmp-cmd-info_tlb.c
>        stubs/hmp-cmd-info_mem.c
>        stubs/dump.c
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> +typedef struct TargetOps {
> +    void (*info_tlb)(MonitorHMP *hmp, const QDict *qdict);
> +    void (*info_mem)(MonitorHMP *hmp, const QDict *qdict);
> +    CpuDefinitionInfoList *(*query_cpu_definitions)(Error **errp);
> +    CpuModelExpansionInfo *(*query_cpu_model_expansion)(
> +        CpuModelExpansionType type, CpuModelInfo *model, Error **errp);
> +    int (*get_dump_info)(ArchDumpInfo *info,
> +                         const struct GuestPhysBlockList *guest_phys_blocks);
> +    ssize_t (*get_note_size)(int class, int machine, int nr_cpus);
> +    const CPUSemihostingOps *semihosting;
> +} TargetOps;

IMHO, TargetOps shouldn't exist and this kind of thing should
be done as virtual methods aginst the CPUClass, or failing
that, against the MachineClass.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


