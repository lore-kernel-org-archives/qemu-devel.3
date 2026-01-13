Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB49ED29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYtM-0007nB-7V; Tue, 13 Jan 2026 02:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYtI-0007io-Vo
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:32:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYtH-00074Q-GR
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768289554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x8sI4RccgbDx+v3JUe/LmmQyK/avsuTx7Mhh7ZsWRUQ=;
 b=YzMHGbM1WJOW/t7DcyKlKb5IpU/uPtPi3O+gR0/i7s/1qkPhzfwidEhEMXQv1xg3wQH0Ag
 yvBrxz1QSA0tMcms5s7t7yopIUVUjM5xGEqzHzxSCnvOXjqXRL2qrAHOJmb6gezsIK3FrZ
 +U6QGcbsJPINeqWFEz0vAXYrHuwtJkc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-XSTba89XNmyiBHZFVZrDGw-1; Tue, 13 Jan 2026 02:32:32 -0500
X-MC-Unique: XSTba89XNmyiBHZFVZrDGw-1
X-Mimecast-MFC-AGG-ID: XSTba89XNmyiBHZFVZrDGw_1768289551
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430f527f5easo3234327f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768289550; x=1768894350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=x8sI4RccgbDx+v3JUe/LmmQyK/avsuTx7Mhh7ZsWRUQ=;
 b=ULwb5ac7EYSZ0Ntbj+87nipfvfO0P/01kUd1dXxD5iJqIBhorQb1I6taOXE8qT/zKp
 DZDk2LQb9B/yNXL9lLM0maOh+MG+MxfyHEmKSoq0kJMUzPltY84a6vsgRr5JmKry1r+H
 ms6pT9+s3uX5u6QpeSb3qEu1nuEa03QJ9XApLvxumQgyvnZjp3JhmYAy2skYfmrhFfqX
 q69qWfj1x1iZfxDrGyGglIZ7hKKYNRkQKYLAvXJitDa7CJsGOG23YmL8lEQXR6bYVoqO
 qzpAF+sT2KnsPPjEkThoJU2hy7m5Ww6IuPp56+vdo0XTJTdflI9NNCCeFZMuQIhuXkyQ
 P9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768289550; x=1768894350;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8sI4RccgbDx+v3JUe/LmmQyK/avsuTx7Mhh7ZsWRUQ=;
 b=pIG7lL6DEmCI102e9gEeNrGQDNnTPJr42aD6twsiNpzLCE0wRsWttr/q2hv2MnPlXi
 GMV+fTW9W99FKAegRQKi0s0dfAFowMOzsoHY0OZmrBCl3/ioLHjOefNCVTY0lNFYYDJc
 CWStBsPGrs7YMapMGQ+nxjoFNq4p9xwo+MktyDmlRtLvY1qZdTajRzIR68LGxD2F+uIN
 FWQY1truv9Z4G4RUnPvNZfz6Z5t2wBv7nvDW1bHebPCuLnr3t9SEgz+my5YUGah5vu+5
 UfYVOIrWNWXznmMd2NGVnweXpK/GmIfgxE5eUFj6cV9Md8XUJx7OMLR7exJkL2yO0VfO
 BQ7g==
X-Gm-Message-State: AOJu0YyXDQVtI24bvLQfh531EQCdiO0KWVXiFw2sScX4Eudtt0kj4rFg
 ic8aFGzAZChcfAdbE43u3fJdDBG7QK9h3UgKVrGBBbZZ+G1lDAKF3nIdAcORfz43gXQpR8rPL9f
 NQiinMgKsFomwa5JKAVglZpGRfvlU++5G+R2m5+iVTlWIugs6uc2x19F0McDWhEWkuiPQtmuTod
 9g8VzACfSeJf5eNCuo9hiThIqFUaRMSUe73A==
X-Gm-Gg: AY/fxX7YXGLXjel5nsNto7gY2bcq+gDr9pu91dm1GDAFSwfRSq+s5qpAHFlwtzb0qyQ
 lvGSvEsecXy1SJLbfFKB9v+/7ahfz7DuqJVCy+gxFHpd0/c6lnEZ5J7N4hKWVxTDaSrI+Zs1jew
 S5+NtoBqOO+zqoJkG08cUz8wS+Yr08EDNyt92lSVdchLScd88qSv6v0kpgLL3WKTlpIkM7WvI1G
 vvH529UtXgcyMprm8GwHWtpdr1YfgeGrcEmmnqWqcLlNQOYDnCyqY9IX6zTFyNEO+3iFpu4+8xU
 qWmxm2Nbn1tgYoVXvMCPo4cp+WSp3e9yBsqaqeTj7WVRYGOEAfHN7vxp490BDzrwdewwPSFdDOZ
 gDegwZY1P1Kvu8Jwb1nv4TcL5ztfuZAilN70p3nJgJxETWk8N
X-Received: by 2002:a05:600c:4e88:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-47ed7c15ec3mr23253875e9.10.1768289550341; 
 Mon, 12 Jan 2026 23:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcfssbU2o+wJbdcA5cpCokD5skKUcPKIrLTb7XuNQ/5GH/pTz91WD5omLeznIw28htmtLbOA==
X-Received: by 2002:a05:600c:4e88:b0:46e:2815:8568 with SMTP id
 5b1f17b1804b1-47ed7c15ec3mr23253505e9.10.1768289549934; 
 Mon, 12 Jan 2026 23:32:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm405380985e9.14.2026.01.12.23.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:32:29 -0800 (PST)
Message-ID: <fbe54081-cfc3-47b3-9b6a-eb7a0c533723@redhat.com>
Date: Tue, 13 Jan 2026 08:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix build errors
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260112161626.1232639-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260112161626.1232639-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/12/26 17:16, Cédric Le Goater wrote:
> Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
> detects a truncation error:
> 
>    ../target/riscv/cpu.c: In function ‘riscv_isa_write_fdt’:
>    ../target/riscv/cpu.c:2916:35: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 5 [-Werror=format-truncation=]
>     2916 |     snprintf(isa_base, maxlen, "rv%di", xlen);
>          |                                   ^~
>    ../target/riscv/cpu.c:2916:32: note: directive argument in the range [-2147483648, 2147483632]
>     2916 |     snprintf(isa_base, maxlen, "rv%di", xlen);
>          |                                ^~~~~~~
> 
> Since the xlen variable represents the register width (32, 64, 128) in
> the RISC-V base ISA name, mask its value with a 8-bit bitmask to
> satisfy the size constraints on the snprintf output.
> 
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ffd98e8eed468645b8ceb8a7adb45718bdc4444d..e95eea024939d2cbb5747781c291fed0e1b07bb9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2913,7 +2913,7 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
>       riscv_isa = riscv_isa_string(cpu);
>       qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", riscv_isa);
>   
> -    snprintf(isa_base, maxlen, "rv%di", xlen);
> +    snprintf(isa_base, maxlen, "rv%di", xlen & 0xFF);
>       qemu_fdt_setprop_string(fdt, nodename, "riscv,isa-base", isa_base);
>   
>       isa_extensions = riscv_isa_extensions_list(cpu, &count);

Applied to vfio-next.

Thanks,

C.


