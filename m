Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2168C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5q0-0006Qk-2U; Sun, 26 Jul 2026 16:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo5py-0006Of-Kg
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo5px-0005dt-8a
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785099160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wt7wCGr/kWh/rgRmz0sqXsHGnxZnqsHOsUrRjkkQJfY=;
 b=HPl00+wYCKrIhZgSgrrSo5QQgu6lKc5xqotyhDAIxPpwshtPRL+AaIDcuL+53LWqY9muHe
 3MmFvcW0Yrwfoke9AMlCrI4+mEA3da8hR7QSICr/d0nlKgQCA79N6qx23yVdQgeBvFeZal
 UtwXRw7fopQY0N1IQ3nBruhJ8KYSZIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-QhGb7yfZNNex7Uz63X69_g-1; Sun, 26 Jul 2026 16:52:37 -0400
X-MC-Unique: QhGb7yfZNNex7Uz63X69_g-1
X-Mimecast-MFC-AGG-ID: QhGb7yfZNNex7Uz63X69_g_1785099156
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954c2d4081so15437055e9.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785099156; x=1785703956; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wt7wCGr/kWh/rgRmz0sqXsHGnxZnqsHOsUrRjkkQJfY=;
 b=OSrfIz/hqmJxr39xyONK1O/vDm52+7p+EX2sXyl3FagcsWgM5GYfdXreGAUoXlcSdl
 B/1NGvvTyoKPeUdNF5HSuLh+eVRjiiTudhwpDdZz652n4UFG+QMmAz61dTvn0Rq5TFCk
 hkc9ToBae7eQVF1/NU3IF9bt4NU7wfbgy6gOdFTGNRUIiGTMXFzi1IvFqodPwAadOZEt
 VwK8rP281WFGcnOBTAau30DWbASnVT5ECDUb7Bodw477RKXecaKSgeY4SxCYlX7I4D2h
 qyEsc2bELsag+B6ho8Fl1vIDWoaP8tTbUghz+Elk9MpcoYzNzeb/XKLEb+fv2l63n+js
 zfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785099156; x=1785703956;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wt7wCGr/kWh/rgRmz0sqXsHGnxZnqsHOsUrRjkkQJfY=;
 b=hF9tn2HaT/UZR9b8+ygWv9wXSsbp2sz2eV8cQT2lK1a2n+gROsPz75I5zVk5IAm/08
 CBPqQj2jf7MdTG7KY4+OLz6FwVlBr7wCSJKj1kLiaH+m1y8WiD9SQ58eeBT23REzu6BP
 kGF4XraIqcyFol9vS33xods/jr3Yghfu+vdT+Jd0IimO1JV8wjq0/ZM9Z+jU5sfFJ7vb
 aY5an8IWAk8R+KpxbghmiKei/78MwCkxvliWlSa1t52DyIT7HDwAuxGnFoGqwmlqQVaO
 ibdCblnp25TUyYuSB+Kj4UFbAs1gUcLgdOV7fFtuCRsZ8shhsSvnJC/1vEW5+bZDXhqs
 zB+g==
X-Gm-Message-State: AOJu0YzT38TnJ/91xL3QG6TP5EqQCsCbjXhKZSGRAsfFOjfy4yMtlzlV
 lInntJ5PynwWnx5KLNKSB2dF/EErMxheUgXT+4pYfYyW6wrJ5AgkbTnRepBK3wKtBgxlvJGk9Kp
 vlCUKO/hqQ6k8Z2B1rLsq/EQnQxTdw9fQLnSCLCI+fg6G26Cg99Cg16qe
X-Gm-Gg: AR+sD10VEyR7b8/UqlJTL6ZJWktMjMbJ7qrIBAmvIXQPTsM5/vmBCcuAD/c7C2hBeax
 xdLwX8bhsOfb/GQZsPjO0So1leKroQcLgz8esILMj9b6hhhp0viQvOLsCH4+3oJalzEuPwZXNt3
 BLEtNStCWiBW6z+tB9xV0rLp+9SGSw7XZe30vR5rvLqiKbkQUQ+AZD9x6oAjWhsPS1dGBcuqcR0
 vZTxoxE4tNeHhcH+7H877EjB6FLE8A3mLhEbobxhg8Ip5OM6pG2J2GPUoNdwkWW36XbCm97k7Wc
 200o2w3yq/pEXrr57JjbRLxkF4qV13mPtqhxKgeovebkqxHhAFhljucnxbsj3vSJvMJiH8AYdN6
 reGcDEhSp6hA5ysAK1cAqCA==
X-Received: by 2002:a05:600c:1906:b0:495:3a52:cd7e with SMTP id
 5b1f17b1804b1-496b5700144mr88493915e9.25.1785099156263; 
 Sun, 26 Jul 2026 13:52:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1906:b0:495:3a52:cd7e with SMTP id
 5b1f17b1804b1-496b5700144mr88493725e9.25.1785099155846; 
 Sun, 26 Jul 2026 13:52:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm192229905e9.0.2026.07.26.13.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 13:52:35 -0700 (PDT)
Date: Sun, 26 Jul 2026 16:52:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
Message-ID: <20260726165049-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-André Lureau wrote:
> When compiled with -Og, gcc produces many false-positives
> gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).

it hurts if you do it? so don't do it then?

> We already use auto-var-init=zero, but better be explicit.

explicit about false positives?

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  target/i386/cpu.c             | 3 ++-
>  target/i386/emulate/x86_mmu.c | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5805d33ab92d..28e4435df23f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
>  static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>                                           Error **errp)
>  {
> -    const AVX10VersionDefinition *def;
> +    const AVX10VersionDefinition *def = NULL;
>      CPUX86State *env = &cpu->env;
>  
>      if (!version) {
> @@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>              break;
>          }
>      }
> +    assert(def != NULL);
>  
>      if (def->version < version) {
>          error_setg(errp, "avx10-version can be at most %d", def->version);


what does assert have to do with gcc warnings?

> diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
> index 8d4371467fd7..65bcccd4751e 100644
> --- a/target/i386/emulate/x86_mmu.c
> +++ b/target/i386/emulate/x86_mmu.c
> @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
>      int largeness = 0;
>      target_ulong cr3 = x86_read_cr(cpu, 3);
>      uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
> -    MMUTranslateResult res;
> -    
> +    MMUTranslateResult res = MMU_TRANSLATE_PAGE_NOT_MAPPED;
> +


This is not 0 as the commit log implies.



>      memset(pt, 0, sizeof(*pt));
>      top_level = gpt_top_level(cpu, pae);
>  
> 
> -- 
> 2.55.0


