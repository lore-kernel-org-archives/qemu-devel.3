Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A44CA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDOxF-0005Kn-MF; Sun, 04 Oct 2026 12:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOws-00050P-AA
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:20:31 -0400
Received: from mail-yx2-x2a.google.com ([2607:f8b0:4864:41::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDOwq-0001hn-OF
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:20:26 -0400
Received: by mail-yx2-x2a.google.com with SMTP id
 00721157ae682-8ac4deda6d5so6169327b3.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791130823; cv=none;
 d=google.com; s=arc-20260327;
 b=p1VqbwvfWny7Vteeaxqgdfka+mtbSCNOoL0pbrqo/N66RrrTlLjMNSR7lBnXhTmOuq
 brJ41ihlfHP+HPQBSsZQs2FKj70UJQ0quOg0Eqtk8qEoJeL2DmdN8JSxEh2Ie3r6GeAA
 WftXw7CHbt52CfPmikXGNrQv6BBfADu2oCFCU34mdW1g8AXPyHzLY05ZSLAwx1I5uRPf
 eDq2Df6Xg+0wlmOusKnSdrXNMSjGuxb876o+5z5awZGVb35KeVIv5DS6Cv0zVoGD6uEX
 /CNWVbbMzvcd+WgFk5PFoZSZFXO2NgPMXp8voOBt3CZXljJ+VOE/TLR4jiwwObv1aPDA
 H2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XepaRebXl3TFwgGX+CNdlobqtN3R550ovzKc4RUOPr0=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=GLFcN2Is3+PlfebsLvX0VU3Ihc/KAwTc6bSk7iK+ITJlLHgdnhqu6p/UN3kxo3yz2V
 qS5kqpH44kKNlhLOHvQVNaqXDOd7IcfuAXScqxYtaWTNhHN9hRJjBSQhsEF/8sDJP5hx
 37J6th+L6WLB6F2/cG2tvq3Qba14JADQYvUOzUW6YIZd2RaYr5q5Usb17wgXfyDgvz7V
 CBkZks4PzJU3CvXyvXxmhimh6UPaF6T/bTmD/hMKeUxgAvXvX/IuBApf3m8luujSjz73
 pKSW7GI8uiLedOwna49inYQvsqPDGHg01zroC0EqQmHumJzRTNj0B2WM61lEs5WCO536
 fmqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791130823; x=1791735623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XepaRebXl3TFwgGX+CNdlobqtN3R550ovzKc4RUOPr0=;
 b=i8KH5Tt5EtMmIBp8DAYICdiRmTFoBy2gb50e6a2Hnopup7CPNc3eX+FBeHcVTYnRd3
 wrd9/YRp4zK0O/roSTv2uTF0oQPH+dulVnEHs/ARa00w6xjF8bcoN8ab1efqwQlleyXp
 ye6CjwBhZgfPfmm05X5K3TX6Y/cfHYaW3aQRDiXqXEwXuwcxOn8qOI0DU2dXlJdCr8fx
 gOcJvOzgDVf4co8zAe2dYLZbQW5mm5ptD45lPI3oheZ2AJoclMtRTljFxnaamtUxJI2N
 ydWIGHEjPygKgp0OGhbfIjj3T0xHF0g7XiobdjE20JATKiILo0DT3P9wJ4Dxxhawzdr2
 F+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130823; x=1791735623;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XepaRebXl3TFwgGX+CNdlobqtN3R550ovzKc4RUOPr0=;
 b=brh2C2nY9tK35dmadhdDp0IE5LrbV+/v/774eZcK1lm96YyCQdPQYoScHveseCufV3
 SceLTB2Z66lM+Bsq5nOoxnQElNTHmQ34uivpQskAitQOspnhNVULZ0U3YVuFe2Yl2ivv
 Os4hEueukPIX9e8vZMLjds3ykmsVaTeYMH+ro5xO2JjgrMFx259E6OmZyAxmCLnl+iT4
 6I53R7R4dKbN71RzFLTtB/JvkcZWxszEAzaiUlFwJo02z+qqOe8SN4pbQ0/+QECgdrLm
 RThQuZHaJIMHBFPwzALuHHCQXgLSjORm7x9u1Ngd5pFozEbhPmHv6XHhOD3Iui72NzBI
 iL+A==
X-Gm-Message-State: AFq9FYJW1N+fQRRjCnkpwyR+oEDbdrk9nuQ1kqtJANkdJ2CW9dOo1iQi
 yLrxAO5mLfRCwQPf+xSoa0gLRZTdL3R8SelxtqxK5pHY40KtpRqt0hbRW3NJgW6NyGJvF8kxW9E
 DkjvxAkrfn/cLGgKNXjHz8vThJSRnmSWtYPxfaYc=
X-Gm-Gg: AYBFou2+2Pj7eStOR3WRtebpxWSSEX7J7eVqcNx6tKRYhWj/EmH/+yz+EttnBzBPLh0
 oJvnhCsnefx73C7dmm4oscIlcsnLtnt8vSR8rzxdHR/T4ExGa02qVUQQasWZhy1q08FH46z8xej
 f0Mw0Gtsk+AQJNtE4lzU5vdafs+w2ZenFDMvuC6iFG/wf7FAgQxxxn5V96N5VCxP+zYKrgrNxRw
 CQ4ILeEfM2WVEejeUPY45sJ2CCkUKDN2eDEU3ZhP8xqISWaVMSZqmjzZiwfqY++FzTSflafqASr
 JeNMHenngJ1DwxXM3qqK5Mba6ZHNOXTiOVe8DdFCC+o3s5GBxJXdy8rJPahpC6/UTv3w2XEM4uU
 8spNQFP67v6k3OnQ=
X-Received: by 2002:a05:690e:1384:b0:677:bdac:d1ae with SMTP id
 956f58d0204a3-677bdacdc27mr1757322d50.40.1791130823248; Sun, 04 Oct 2026
 09:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-20-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-20-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:20:10 +0800
X-Gm-Features: AclHuK9uce4zIeqTWci0lI95PQn3HbKjdOl6huCTP9O8nZ6VLSNWA_MLYp3jL5M
Message-ID: <CAEUhbmXmghW1GLFUQjXRivNKQ3cVeppxT+-G=F9Ecgfy1RM4BQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/30] Kconfig: Extract config IMX_RNG from config IMX
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::2a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Oct 4, 2026 at 8:33=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_RNG to eventually eliminate config IMX.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/arm/Kconfig      | 1 +
>  hw/misc/Kconfig     | 3 +++
>  hw/misc/meson.build | 2 +-
>  3 files changed, 5 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

