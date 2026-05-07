Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF68CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKyXM-0005N3-3M; Thu, 07 May 2026 09:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKyXL-0005Mj-0k
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:13:07 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1wKyXJ-0004Om-Mk
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:13:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1778159578; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JR8NN6Uo7P3nrfQGZoo3s9bzpv+krRXLIb9eQy2Tye5QTNje9zGtMACwK/NlURWvNXrwdJ5ByYCdqwJKU0661oGRjOt9F3JQljD6MsbnuIjpayl91u7ouGmQoaDXd4jiVFmDDvdOsIGkOk5n1lCtMOAu25uOx2rhInkdnCcwncI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778159578;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=S0WSjeIVJ0KX1fuzrXbx8wuMlUjbRumButsjVGNqxCY=; 
 b=QBeYDQrswpPA1AO94a3ei1py1UEU1a2To9DCV+xB+FbGceFByqyN4DIl+KUiOFLrZ6ZBbOHXRkZJW1I0mpmBExpuJE4qx4e4j6OyYY3/OdNVCTfRQOP3k8NTEoH8O/nbemGyDo4FxiMJtb5vJnoajvV9V12v+NqDQCZGT0GwIDo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778159578; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=S0WSjeIVJ0KX1fuzrXbx8wuMlUjbRumButsjVGNqxCY=;
 b=pLZLjB6dw7jla1fVoEnM00956818Ok98xyJUVoBj5YRzwCDyN4MPaU+Pe1rzOx8z
 nATJ/EInBK3dPgD9oTJmnEsQhXgbmRROitUwMVt+aTc2kBlY9nd/lZ+3FTBpe0RS5bi
 ckjrPuHrv2YDm/7sy0VeVioc2V2vctP7UMTO6QUc=
Received: by mx.zohomail.com with SMTPS id 1778159575066423.3317597299491;
 Thu, 7 May 2026 06:12:55 -0700 (PDT)
Date: Thu, 7 May 2026 13:12:50 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/7] accel/mshv: move vcpu arch specific
 initialization after vcpu creation
Message-ID: <20260507-tacky-sweet-stoat-cdaa43@anirudhrb>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
 <20260505185028.237207-3-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505185028.237207-3-dblanzeanu@linux.microsoft.com>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, May 05, 2026 at 09:50:23PM +0300, Doru Blânzeanu wrote:
> Call mshv_arch_init_vcpu after the vcpu is created to ensure a valid
> vcpu fd.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 58af674bd9..e3da583f21 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -415,13 +415,14 @@ static int mshv_init_vcpu(CPUState *cpu)
>      int ret;
>  
>      cpu->accel = g_new0(AccelCPUState, 1);
> -    mshv_arch_init_vcpu(cpu);
>  
>      ret = mshv_create_vcpu(vm_fd, vp_index, &cpu->accel->cpufd);
>      if (ret < 0) {
>          return -1;
>      }
>  
> +    mshv_arch_init_vcpu(cpu);
> +
>      cpu->accel->dirty = true;
>  
>      return 0;
> -- 
> 2.53.0
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


