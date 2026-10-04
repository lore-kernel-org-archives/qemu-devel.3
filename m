Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72425CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDP1m-0001BU-JM; Sun, 04 Oct 2026 12:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP1Y-0000vT-0U
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:25:19 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP1U-00028D-K1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:25:14 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6714595153cso586052d50.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791131111; cv=none;
 d=google.com; s=arc-20260327;
 b=iJVWFc+sJGRKG9s93vtH2/mTbwKnZ9edZ3yMTe8dzmonrOwkSahe/QHyBfWu/0lhez
 7wWdKHjijALnGXNHot3fnkVkEjFj4G7MtLooVG+oIH8Ek36rRRzWCJXq90St7H0x4vnL
 aC5XXG7//GKrkiEjzqtEk3l5mgpfHx+CSSMOqcCejcSGJJ39iOOR8mrk+URNqLixYtG/
 AxV93j1IBKQGbUBuhUolQnz2WB5sEWrNtBJcUBui3V840dWUTdkpld4FBJwu+od0xsdD
 2oxbKD7IOVz6erORo91WcvQtGXsw0aUWkO4d1V0wdA7kBUbhhx2uapbFZNHpYooq4oZN
 Xrqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WvKToV4/Sf6+OaHiyZRW6h48VKRpjAkt0F87hwTlvd8=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=AUlriOWsTpOjBLiY+99wee9/gRSWiWsJoNrxCDXgG2Aar/PKDecE5ffhEomgnV8yHi
 78w9+zoho+r+cv5dgLRXgH1bzeWKCz7AOsdTHRk5nRP+tWCGZMaWQFFG9scN/Wg40DQJ
 wx6xMK0VY1v0BWxsLlE8vlAUwBUV4BlT2u0kp0p2CY7wNZG1B5UamgqKwN4EGgP9C2A7
 53IU6D5WrSKX6aWhBF+iT5agzciET1b8kflh3Yi8qbvlRoa/l6F5B3QETZRnlR7xElsI
 3rsQER+QmGu7g5AWgT2QOPF8Vpd7btSCKuxrm/rLrO7pa7j/11yxf7KVN7I99g1FCE5Y
 e+WQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131111; x=1791735911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WvKToV4/Sf6+OaHiyZRW6h48VKRpjAkt0F87hwTlvd8=;
 b=LPC8m3/au/AJMazkI3i38PQz5Xr0B8SyTrLyd+QjAdtrrlQJw+er0O1Q7gP0/NUUcI
 Vw1h0pcs3QC2isLYkES3rDaJ6PnGiOna9LbZjsVh6+dbyDgQR8x4ztK9571banyiOybp
 OfpsOE6T5L1bc21DHwav1o8JeZTubXUrtyYNW9UpZo7h+i6bT0CutsqsGRIeErNRwGdD
 HRXGsdMbwFEByh8Y5z6PIM2ACuxvMHvPuO6ufnVvodu/Sva4VwhR2nvTnjzXGCFBp5ID
 EAB4+ARkN0NF4TJqhzGYzwOLx2WIgxtDA9Thkuu0dL8AENIG6I0QWQUjj5VEZC8YVa3D
 627Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131111; x=1791735911;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WvKToV4/Sf6+OaHiyZRW6h48VKRpjAkt0F87hwTlvd8=;
 b=ATWbycfBhzV2XCLY26oZop/+zJDAiX5xAT3mt6LqqFZp9SPDvrc3/A9XADlmVLdu3i
 jxhztPByGUe+rsqIdIK18zx7KkoTDvoFZIqyu3mm8Mrydw9FgfgxuCuiOjKtSOIXrJhD
 vuIGXBk136LRYQ7oM6gMllHcV4yvVFTY780VE2mEC2GBkpKT8TrmXWWzbVWEYDGPQ+6b
 YkAsUrKtbullDUZEE330XffeaO6mL91sYMew1IpFQGoQxVcs66vF6e5NLujw2EVJ88in
 SLy3+8ERErf7Fj9swQOMXaGYVkRhzR3UFeoIlUscht8l6cS39O/GyZ6o5MuEnimrCXu7
 ZAUw==
X-Gm-Message-State: AFq9FYLcwZo/6ah29wumgTLNrsmzYt38xi9Xumb3hyTauuipzEpcsmA+
 rCy65//nWUHhuEtz7pTodzURVlTbTy3JNAPo8CnCXAFjlEXJbZKegdBMa/i3WQRnZwvrYpWRfn0
 kNHJsuphyWkxmMWJLXaHq8iFi/djOSNE=
X-Gm-Gg: AYBFou2BHuNAYprpk2/IOUWGSi8RYDpF3dTdimZXD7mHPJjqrQcGwsAY6X2UNVb/iwp
 WBbKMwKj539nMV6UIFxh8/pF6bit9u1wSEQVXAUDSNfdzmSdtKdBn55oBItJcgf05nNa7A90WBQ
 tIF7+FzRxwrf6BAi0vWEDmMNnQIVIhxINE6hN+BUJbPLds6LzOwzZ08qGcYZWnpFhmvf+2/s5wa
 eb3dOcTjU1OpVXXiVXuB8wOdxZzTKU/Ipl7QCeKZWuLvOH4HaD25tAuDFz4GuhPIGE5qhjE/uqR
 K6nRBvtYJLan/8Yzj+Zk28rxjKrgj+SCTBtCbWz89oTPa/jOmf5S/2EdIHDG9i7fBPByyrpA7K3
 VdX+KWMH4dCiDoLg=
X-Received: by 2002:a05:690c:6e83:b0:8a8:316e:5973 with SMTP id
 00721157ae682-8acdae8d683mr54135017b3.14.1791131111425; Sun, 04 Oct 2026
 09:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-29-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-29-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:24:59 +0800
X-Gm-Features: AclHuK_jdf0bdEAyq5jHgex5dK4OM_6A_4iLj_Ekk1aA_GFIZaOhNMlCRVU-nTA
Message-ID: <CAEUhbmWwb_yoM1Hty3FSduC4wGfRg+mzZ4N-qX1hZdmKbEcWCQ@mail.gmail.com>
Subject: Re: [PATCH v2 28/30] Kconfig: Extract config IMX_SERIAL from config
 IMX
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_SERIAL to eventually eliminate config IMX.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 7 +++++++
>  hw/char/Kconfig     | 3 +++
>  hw/char/meson.build | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

