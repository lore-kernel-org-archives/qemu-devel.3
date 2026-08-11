Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5EDC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtljH-0001Ap-CM; Tue, 11 Aug 2026 08:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtljG-0001AT-2f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 08:37:14 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtljE-0004UV-HM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 08:37:13 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-81f36179dd5so39493187b3.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 05:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786451831; cv=none;
 d=google.com; s=arc-20260327;
 b=SGih8FbJs5FT9oJ6lyBZo8FFNy9XEeSzgXA27sdGZtHOijEtv0cWLeAE+dxPbznBNf
 7YaC6mOBXUvwdRWr2piRcHCGizmuK1RV4gUUriroBG3Qmk0Ojz22ZUp519VwsFQpfdr9
 Qb5s1sX7SQYBVLkH0wD1q85Q28FHK3XLgqlvFbyoaGE3/eyGblO9qmN5LDj755SG/gU0
 bwdRgttnpMX05r86RIN5BqW+cyyMFmR5oxkriEULd8hy7SrNnhuru0vFDCdn4H3hSGGy
 iaCQdi4zKAW60wzkLn8tg3jVAubKLLW7sixCkBMnUBHp0986bSZgMlMabwpjgLnInD5i
 Lknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0Hvj+wrc631AZA4YVy8LgxDeRYYfDIgyODUNomANRKc=;
 fh=ZHgkT1embQC1Ws/ngMa+lKOkAvKamAhw0AO9fvQNV0I=;
 b=sO0w3Q21Jk9axJNUWEVWeG73aJCcU037eUzcEskD9W+mRMoDXLYrYC4Oytdr+B7cU0
 GCd7bxisGoQ+OLab/dy6slHa578aDNnkl5mInt7Kp3nQaZ6TnwUsxyalEriApWFwxfhn
 n+y7Ov01se8AV7iNHD3f9CQSgO/auOhymOvNaqSn8L1jbi0sSsUSCgReI7qHF8MMWVx2
 JHi4ptpo2LJu2XAK6T3gdIIkM8bEKkZBRo6WIsPJFWDSGGsfQmtv6EkeUqHDwRWWGv+g
 Z3TjcQ3+cJAjGXLndxIwKwDOgw2gboEBtLd5lFCcwuLfe/8jjPfCOE80FrZ5Zyp3MwnG
 mRFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786451831; x=1787056631; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Hvj+wrc631AZA4YVy8LgxDeRYYfDIgyODUNomANRKc=;
 b=SB8CjVEnX19qiaEmv1ywI5tXdoDU/vBoCdRB5XoTfzO0HvQuPVQ0V0PuRkO0rFkSpD
 iLhVgYK8wswhDbiHZVtAKcpWxq4GyngzQ3NtNCRkFAGFyQBEBd+PO8jyeSqePhdsEUMy
 Aqa6IWUO2R25l0ovMdYtr7yQ8sjCyk7s8/fovvHnsmCJZ+QBcHZkKW4uixEVzDHxXT3p
 UEnYGVRfvKITzdKYsRSYWC0gPBfFdkfV2DbGyLppgR3OKQ7ZZQAeF3hcIa4fWCOy0vVr
 6moF4sEw/T0B7+O14lNzhE+ebSjSGZDYa3m3wVtCe/aC2xbBC/REETvUkxwbdePrOxXF
 2epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786451831; x=1787056631;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0Hvj+wrc631AZA4YVy8LgxDeRYYfDIgyODUNomANRKc=;
 b=fifmPQLIOO0pZ2fW/1zC172lrt+kDBRkrY+BC68EA9dJKXRcJ1En5z/LNiEXTHE3qB
 6cJHzH9jkK4AJ2O97bwY6YQtNWgBcYXLMv10KHOg8pGciFrKGtF6JMO6Kfs8XHjsHurS
 2ARXr5dv441sBB12JDBaDuRq0jC1vc/v1k/RupS4Y0hl1BmUHRiEhkwoKPGq1AJ1Igcv
 uTGRz/l2Rq5TKgA0HY7n9raaf8NIpJaDyNpYQVFpC9DjTOaElIZ5y4YMD3aVIYEiTH2M
 MvVXqtW8HTp4Ml2fQ7UC/rtAGPH4OoMPUSpl2CWDX40RZeqhIT9p9zGo74C5JfnsmAP2
 MIjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpATu4jP5Cn/yXlReaBuyPAZTWRjPiz3vYzQoAsIagzGKrUt7WjP5xOA9RbPf6QtS2qmuSegVEDJQVN@nongnu.org
X-Gm-Message-State: AOJu0YzwWiB59fec2cWEw1cW/rMo/B/ssGAJp5ZbgeA53GAArLNjFnIM
 pAp0pIWBbWvhQDEP7fD49dfWBGgdEKj/XiBFPFX5Wn4X8ve1Hazlft+YgM5XsUKnWGXCxWcFngC
 jZSgqSWNOPlZGQ5DoF5IFUr/uQ+PKFHvEWBZAbMbarkXnpD83Bm6F
X-Gm-Gg: AR+sD12vfwq4bYM5Uqwb8bNIugI7//Xy0yKjxHt+r+vgSL5858DzAdG3/2fbT4mhZvh
 gH0cZSSSOgbIHAoeorg0lzt3UOjev0d6eMLLmnscOC+84g8y2VfGZ6kdXDSTtR9YE/rd5Hcaj58
 7WWxF3SNLQiURfeCpyEdxgyBBTYfagBlpfC6kenHbtx0SoH8DUQHbRuXZLGfXGkT3XKi6qzozJL
 FYDT2idTsfslnZajRhLSLrKenXEonCXfiSDVHtP6LprMicUixRdAU+zFgPa3i07Q93chZlIcpr9
 XPZde4OoNAbJPXKnOeVPYSml4aw8KLY7AoMJXc+DD8AtYXIpooPgSwzoqv2tt5P28EI1FiDdd0h
 eNEgsAUdOvWAAj1S/+emftXsPn2g0
X-Received: by 2002:a05:690c:6e8f:b0:81e:8112:c5c9 with SMTP id
 00721157ae682-82f26fc886fmr20852107b3.3.1786451831043; Tue, 11 Aug 2026
 05:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7CCA5131E298B98FB02B48E362186F801A09@qq.com>
In-Reply-To: <tencent_7CCA5131E298B98FB02B48E362186F801A09@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 13:36:59 +0100
X-Gm-Features: AUfX_myBZJveB-9Wp212FdADkgo-jqBgpbS4fpwcuJ48q79tboQYp0m_R-NaPXo
Message-ID: <CAFEAcA_LyJj3sXMhSs5g9=C8fXMp6TMUcFqXZwrPeHd4XYWJVg@mail.gmail.com>
Subject: Re: [PATCH] docs/nvme: fix doubled word in detached namespace
 description
To: Leo Cheng <leo-cheng@vip.qq.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 11 Aug 2026 at 12:53, Leo Cheng <leo-cheng@vip.qq.com> wrote:
>
> Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
> ---
>  docs/system/devices/nvme.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
> index 98a4401..531f156 100644
> --- a/docs/system/devices/nvme.rst
> +++ b/docs/system/devices/nvme.rst
> @@ -142,7 +142,7 @@ linked to an ``nvme-subsys`` device allows additional ``nvme-ns`` parameters:
>    are hotplugged).
>
>  ``detached`` (default: ``off``)
> -  If set to ``on``, the namespace will be be available in the subsystem, but
> +  If set to ``on``, the namespace will be available in the subsystem, but
>    not attached to any controllers initially. A shared namespace with this set
>    to ``on`` will never be automatically attached to controllers.
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

