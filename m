Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36625C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDPt-0008Ur-1m; Thu, 02 Jul 2026 05:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDPr-0008UC-Ng
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:09:03 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDPp-0008Kp-Tx
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:09:03 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-664b84118d5so2525603d50.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 02:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782983340; cv=none;
 d=google.com; s=arc-20260327;
 b=ZFxerWC2zS7+jlIZKvZJfYbK4nYufT5m9KZ57vkiMNP9FQhgIC2osT7pT1BDPORtVP
 qybIUuw6z7PaiDoS2KeDMtPBKVU5LdjH+9LCAK3xGuwdjIY5Tm7MaOjmk5l/1Jv2Fq1K
 L4u3aPGjLvEs9bVgDA1cFUq8xElI2+okM88EIlsFInm4zGZOHZNG2JUBBA90k3IWFrt8
 nQEUs4TLUFHNdu+7oUNWA7Tjt3V1+ZMa5EDFtufjds+QPG5NCdQ26hEqNuh3KK0TQj2t
 u7cOyhzMxaq8uSvOuReWhchQwuy4/lsbUm/vb2Kpy/FI9wvlhUGPFHfLaO7ZzTAtpvhb
 jyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tled533TET3/Y+hjDSa2Rw7waDndRzvPNWncCs/shvI=;
 fh=x/UFvUes5DiY0k3JVO4V/t/IE05kHPu2wawTUY7dV4s=;
 b=Spgw1/Xcrd0MW3eeutPkJcyBea2B4rm5zeULUdK5MDYGaUx+WhjTHZJBaJLLWIJWkZ
 kYQoZknaSoRX9wnPLh5YoRHCx9v1myz1mL9NsDDVZE22pLrj2Tu49IRb8TyPCGafb0I8
 n/Es8NySeHqq7hDePq7D4F6Il0goEnFMrLPnUUzeDXnbafRCYluAiwhPC8ElOLMS1ugD
 hmf6lNbCFFMejDxf2FbWhW6507IY0hXoY2aCs8OJ9v6DVrm1egFf+1tBd285L02IDisM
 r2zsrQLSSbrJyA5aLBAsrNFXGDRcUVDya2LC+/J1OdKBCM45RRrZgRtFnPfmCDhh5HV5
 NHBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782983340; x=1783588140; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tled533TET3/Y+hjDSa2Rw7waDndRzvPNWncCs/shvI=;
 b=UbCEleiw9rQahCZV9hWP2MzqcbmHVilJt484ZN7ZXjLjHxy39qGZ7vMudobYHBK2f7
 dUKsMR/Z1iEt1+jwG6eYS5mstxQ5fLTL/5kgAyPV6qLvfQCLp4DQzoqM5ZR3M5fuq+rO
 1kDLPc4NSwtJjenyKDSwXyI4iEuud0s/6uDQIkdmNdi1nTm3z9b/DEo8vhBDBDEvmz+n
 uAeLHvc1/3ihODnguEL2dfr2uiM4lr20Ml5rmeuu2vpPkcn6szCmGK/JPN+ZMbRtkGof
 Ttzz/9d9UPhxPHc51Gqcx4Z9bDohLGY0dVrM3J/NDgSsLehTi4OWGxyGsFC3p1RBdbA8
 1pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782983340; x=1783588140;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tled533TET3/Y+hjDSa2Rw7waDndRzvPNWncCs/shvI=;
 b=AFRwQZB1jUhNk3XI5ldsVMGMeXDGK15gJnoDTmDQ2gxfrFwUHJyzphApBqSsSxamwS
 u2ILb4drJKNv9VIeUv/xMZbDKqwS06tYeoi+mDDHCUHBjd57lebAYrv+p5DsN2DfluaZ
 Kv/JVBAm7YuopjXYjo6GCwnpwelHFEGOs9JJxKTT0syIfkKLGOA39qUZf64JeQn1hqxU
 z5H/megKR4BVkhvlRoaeFYWrMJLafHkvoEkezG2qB8/aLfUyI04+BdOVRWvOAjul6CCI
 n91ZKrEPx8U00dMrGKSlUWt2qLfP9ssuc9Gs/GSyB+SQmyUIwOR7/kSVmZFfGzwEGpYG
 8PnA==
X-Gm-Message-State: AOJu0Yys6Oc1PDnsFNNuvqX1x5OTwCwZ2liSAg4qdtO+A07Hvia19tdz
 9YazacLasUmsELRN2ZUjmo2ZrIQWCWZw14VrfMdD3Poez4ZVx2P4GbOTu1hesIlcnX8WDbqppO/
 KOvpVay6dF2Gkw8qJz8c7lGi9SicwZPBJDREHI4HLpA==
X-Gm-Gg: AfdE7ckZ4E7huwKPDJpW2ZHAgC+ega2grcd+XAtbIo04V9dM/ksaQZF1PklitlEvtZl
 oItf4RZUFftP749nZnSt1Aucb47Hv78BceLbWuDzB/bPVS3aS032RbcArdTACvqT8+ZLUjikjGg
 KGcgpCrf5HvFxqmnOVGrwW4ImlntiuNHzRfrs5Wd1YWMbDy0jSA6bLdKreA4DBPECViyy78Dwzh
 iOxnyjs9VCN+0usuaSdRBuhOLC5tcq65HSZFiG6YN+PgKnNFkkOF2slMdTAFfsW1AbTm0o1WfSr
 ndlPFs0Pwf5O2RHlA5rOgGKJqgVYGhn4BjOiauGzxHmNNA5UDZ+p6s76
X-Received: by 2002:a05:690e:440e:b0:662:d3dc:e9cd with SMTP id
 956f58d0204a3-6652199219emr3914800d50.20.1782983340118; Thu, 02 Jul 2026
 02:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260702090527.4167310-1-kraxel@redhat.com>
 <20260702090527.4167310-3-kraxel@redhat.com>
In-Reply-To: <20260702090527.4167310-3-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2026 10:08:48 +0100
X-Gm-Features: AVVi8Cfc0Ue87q9XnJz7rb7Z304zOhFGvjbFkhwrqWbQPBvyc199tIsNpOls3ec
Message-ID: <CAFEAcA-eFY6yeSZFL0sr_PgYyQZmguOkvCm+T0Xs7JSkD4S9ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/uefi: disable debug function
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 2 Jul 2026 at 10:06, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> This was never meant to be active in production builds.  It's a code
> path not hit on a normal boot (OVMF wouldn't try variable updates which
> are not allowed), so this went unnoticed.
>
> Wrap the call into "if (0)" so it never actually called, but we also do
> not get dead code warnings and can keep the printing function in the code
> base for debugging.
>
> Also fix the name printing to not overrun the entry size.

This is burying the lede...

>
> Fixes: CVE-2026-58582
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3615
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/uefi/var-service-policy.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
> index 989bf87ddb86..f78c8f01d62a 100644
> --- a/hw/uefi/var-service-policy.c
> +++ b/hw/uefi/var-service-policy.c
> @@ -40,11 +40,12 @@ const VMStateDescription vmstate_uefi_var_policy =3D =
{
>  static void print_policy_entry(variable_policy_entry *pe)
>  {
>      uint16_t *name =3D (void *)pe + pe->offset_to_name;
> +    uint16_t *end =3D (void *)pe + pe->size;
>
>      fprintf(stderr, "%s:\n", __func__);
>
>      fprintf(stderr, "    name =C2=B4");
> -    while (*name) {
> +    while (*name && name < end) {
>          fprintf(stderr, "%c", *name);
>          name++;
>      }
> @@ -173,7 +174,9 @@ efi_status uefi_vars_policy_check(uefi_vars_state *uv=
,
>      pe =3D pol->entry;
>
>      uefi_trace_variable(__func__, var->guid, var->name, var->name_size);
> -    print_policy_entry(pe);
> +    if (0 /* development and debugging only */) {
> +        print_policy_entry(pe);
> +    }

Please don't add "if (0)" to the codebase. Either drop the
code entirely, or use a named #define, or convert to tracepoints.

thanks
-- PMM

