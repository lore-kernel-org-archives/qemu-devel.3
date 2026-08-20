Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FADC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx26u-0002R3-Pc; Thu, 20 Aug 2026 08:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wx26s-0002Qh-W7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:43:07 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wx26r-0008R8-F1
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:43:06 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-836c91bd782so34019037b3.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229784; cv=none;
 d=google.com; s=arc-20260327;
 b=UD4Xc+XCDfJTMmaDmfjunlENoHvgYWgBsKVawcAbnwBDj4Dqzu3ecfB9PozXE/7rM7
 2tLM6UeVK7+EoCgDlmfQGZ88eOenwaBi/jCIwTWqS85nNvSjiLmLxpBUI9ZoWIDPZLDb
 evoR+1rmrAlMbzyw2TwYT2qEN9QuYKsYjZrPhDjnpMd0KcCJ2h/6S0Ap6XJ6ftFW9Q/z
 ponKrHJTnika+2oUAKdQ3EfCBiCJfIo2wbV3/neQkS587jmPY/LrV3F7Z3Q5GAn+ssu7
 BtLOVA85+FMueX2FlA7KSJIy6pmEOXLxaQb2hNPUxYs0Cv2e3CI6tl8AH9OwfkXqk/cE
 eBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4wRLevoD232dC0fMLVIDvK2LvgUsHVjEmhAUBp1shCI=;
 fh=RJbrQFIeyP6KC7TaOsVjp0RMlnbD+UAbLs8m601VrFU=;
 b=hs3ByD/XmQU/3Wdi/tZ5bqfsn/A/k8Y1m4QAN81scqFAuf7fmhZnpVhech6V9HHXw1
 SibZUFz2VVXvq6oqepZ+oLx1JyB5DDGjsQY7jVnBICinUxJvCEUDiB0nE007EScCxf4g
 k7WwTW8834553dImuyiEXVPKfDfFq786fPN6jpGjaMWu67diPPELDK6MZodmCB3S4OAE
 ItUWto9rj+LoKalnRkqbNOcXmBwVi67T0GsL+t9YsxMcFfwRWva+pu8OkwzeiduuPhBC
 hCBXNuIsQh7rJ+yVlR22jAhUG4G+lWBUgHa4ISrm9gU50T8gjB3o5CA3aN8ixzJp0xQC
 SEjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787229784; x=1787834584; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4wRLevoD232dC0fMLVIDvK2LvgUsHVjEmhAUBp1shCI=;
 b=bgHsWDX1tGQDpKay5csYtVmlB6mZrIwUZW67EHjeSkIdngbdQH6XcikrAWQc6tCcN+
 NsKm/iEMNq0jLcpILQvmGdTO2pNC97Bh8RPwEvKwx9xV8kJGvVCJeaREblVO7kWd76qG
 i8U3pEEeUhjSjtCYOP1bIO71XwzsCFsdqUlr7vDFB41kfVPzw3kRclxotapfEIZbdxG5
 JINBAZ484XSBo04GanesKuOYrmDCt/9yk/uKNRScvZUWqFpyWy/HBOejtzAcjS1Zhnki
 Iy4xen9S9/zLX5ddBhOaQGJjMXFc+WapMzHKafUVyNH/9yVdLK8UTPIF8eMjRvYUwzW7
 SmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787229784; x=1787834584;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4wRLevoD232dC0fMLVIDvK2LvgUsHVjEmhAUBp1shCI=;
 b=cSVCQe6ET1j7swiJ5JZegqTuiBGXpfE+QrbDFbA9c7AZnkg1BRWqrEX4N60qk1v/Ty
 ug3s2YnQ+zmP2X2rsw0bATk6ZkMRD8qZmRz+UfpZNM2L4vdseVTurQ2GntFn0VTlWonn
 WDbLNkwIAB53s+E1EvUQ1T0RvRTd4KQJaMXStNDdx4hGYkxlGh/Qs4rRNmw9HFLFKwlJ
 7vTahAuJmiFlwMGy1qxzBWBUGHBAaGIul6MwC38W1yPfd9TZ8oAhtReClwdsRKKCMeFi
 WhhoNNAuMbQXSyiEylUK7vSwvtk+8ZnbDhMzUCKBIwEBHRsaTtlnq2xa+B61ajTE6kAw
 oULg==
X-Gm-Message-State: AFuF++kWge90pwKjIPlqvbA5Xq570FoSQLaLieFrNe4b9HUOu5Ud/X9W
 jdq3sgdhQm24ip7Re1pCUOwL4Sp6tZV18cOAo0nRfBvQuZAMS55zedRrA/b5PTX2Wg43M/f8YVT
 CSFqtWR4rLYTEAEcTtpmfJqB0bQEEwjzlb5wa
X-Gm-Gg: AR+sD10KChYgxQjfPR/6tGLKxH+xw/jiD4EPUoYy7CJuVYNlqC6c+9F7sBSVDiUqQOt
 AXnqWGSSA7AM3GugfEcy+qiw6u894R5QZnijeUDhTX56h8lele1ePV/rYXyyHQpj3d+QoOdxh10
 5Occ7hj0S2QxoFPEAmnnu0/TKzouXP2m6s2Dj4gfNxEKAl4Rv/5zb1u9KP85f+PQwl+Dkyt29yl
 /IjuGmZDxM2POJ6OQACTHEkcPh31OUGRciNgLiLDPKypOpgllzd4CxpYAoq4pmboL+m/JGbCF/o
 wbC4Vui1iHFzeQFsmZ1D89wewu/yivWAxmdy12dBPt2OU80clREDUWn3Og7SesMZOI5DgY8VHuG
 i
X-Received: by 2002:a05:690c:e3c2:b0:847:8ef9:fa2e with SMTP id
 00721157ae682-8478f093dc5mr18871347b3.10.1787229783881; Thu, 20 Aug 2026
 05:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260727161157.2112984-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260727161157.2112984-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Aug 2026 16:42:50 +0400
X-Gm-Features: AcwNN1XLZUk_KhKukGb7GqZnIDzSGVo2Bx6rSx24bcL8WER_7b73yRV4HfHDINc
Message-ID: <CAJ+F1C+HFheJVen7VMwrf1VQ6bUJFMVNjK-pcYf_1r_jkMbarA@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch: warn on duplicate trailers and
 self-review
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, chao.liu@processmission.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Mon, Jul 27, 2026 at 8:12=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Detect two common trailer mistakes:
>
> - Duplicate trailers: any trailer (Signed-off-by, Fixes, Resolves,
>   Cc, etc.) appearing more than once with the same value in a commit
>   message.
>
> - Self-review: a Reviewed-by, Tested-by, or Acked-by tag from the
>   same person as the patch author, which provides no independent
>   review value.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping

> ---
>  scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 03f35e75012c..a9326297d626 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1539,6 +1539,8 @@ sub process {
>
>         our $clean =3D 1;
>         my $signoff =3D 0;
> +       my $author_email =3D '';
> +       my %commit_trailers =3D ();
>         my $is_patch =3D 0;
>
>         my $in_header_lines =3D $file ? 0 : 1;
> @@ -1795,6 +1797,14 @@ sub process {
>                     ERROR("Author email address is mangled by the mailing=
 list\n" . $herecurr);
>                 }
>
> +# Extract author email for trailer checks
> +               if ($in_header_lines && $line =3D~ /^(?:Author|From):\s*(=
.*)/) {
> +                       my $author_info =3D $1;
> +                       if ($author_info =3D~ /<([^>]+)>/) {
> +                               $author_email =3D $1;
> +                       }
> +               }
> +
>  #check the patch for a signoff:
>                 if ($line =3D~ /^\s*signed-off-by:/i) {
>                         # This is a signoff, if ugly, so do not double re=
port.
> @@ -1811,6 +1821,28 @@ sub process {
>                         }
>                 }
>
> +# Check for duplicate trailers and self-review
> +               if (!$in_header_lines &&
> +                   $line =3D~ /^\s*([A-Z][a-zA-Z]*(?:-[a-zA-Z]+)*):\s*(.=
+)/) {
> +                       my $trailer_type =3D $1;
> +                       my $trailer_value =3D $2;
> +                       $trailer_value =3D~ s/\s+$//;
> +                       my $trailer_key =3D lc("$trailer_type: $trailer_v=
alue");
> +
> +                       if (exists $commit_trailers{$trailer_key}) {
> +                               WARN("Duplicate '$trailer_type' trailer\n=
" .
> +                                       $herecurr);
> +                       }
> +                       $commit_trailers{$trailer_key} =3D 1;
> +
> +                       if ($trailer_type =3D~ /^(?:Reviewed|Tested|Acked=
)-by$/ &&
> +                           $author_email ne '' &&
> +                           $trailer_value =3D~ /<\Q$author_email\E>/i) {
> +                               WARN("$trailer_type from the patch author=
\n" .
> +                                       $herecurr);
> +                       }
> +               }
> +
>  # Check SPDX-License-Identifier references a permitted license
>                 if (($rawline =3D~ m,SPDX-License-Identifier: (.*?)(\*/)?=
\s*$,) &&
>                         $rawline !~ /^-/) {
> --
> 2.55.0
>
>

