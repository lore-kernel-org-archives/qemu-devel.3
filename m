Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4EFFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHdQ0-0003EC-Aw; Tue, 28 Apr 2026 04:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wHdPx-0003Da-1K
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:03:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wHdPt-00036u-5P
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777363414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPudrdLn0IK9sImuSyJc3hr6uP5V/FxPl5nefsdVox8=;
 b=f1Zn2OPfyl0GKs7nbOtokh3LO0teNRQmWtF6jOnYjbyElzODRqt/V2LJBECi79cNYe3c29
 73ASGcMdL9RjP0tLNBe0jzGaRDwMyHEjBjsnJ1WRoUut+us0tHT8attBdJlZ+mo0RLxBVi
 Q2ywUGQJTLNZMo8ER0Co24QiwlTqgLA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-Hwwymu6vPwKHp6FK5fDTUA-1; Tue, 28 Apr 2026 04:03:33 -0400
X-MC-Unique: Hwwymu6vPwKHp6FK5fDTUA-1
X-Mimecast-MFC-AGG-ID: Hwwymu6vPwKHp6FK5fDTUA_1777363412
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b461b36990so120912825ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 01:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777363412; cv=none;
 d=google.com; s=arc-20240605;
 b=hRp7IXucmXEOjEQw6MrIfNC6gva3HaUs3v8df2ctFbddxyWCdECWCUEnN36pRV5aBE
 uRlzz2Yzjt97XHHDrAm04Z1Vjao2uCzMaMWw7Oz9kqjY+7VUxu5YTp3M45pPmRbw4WUb
 DcuOPVnPozHv7etu0izi/L51KH6hC8Iq1y9RpLB2GirZgzauZXa2FfkrUsP2beRtuLyh
 Oj0TUenDEA9d1OMbQQnynu13yftnby37WuS0f9m1xFW67nU2QZLofD8lZYgmtWgMpJqZ
 0huZRuHHBHaLnFqjnzkM/8T5TITVii8FlB5TRcXEBqo59TIXz04qvPSLaMiGmTup7D6z
 nBaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BPudrdLn0IK9sImuSyJc3hr6uP5V/FxPl5nefsdVox8=;
 fh=Lp0EzGRgIYJPnfuILsQ/Ksar4E7WyhbafxG8toaFkq8=;
 b=DzrNjbfFSsNpC21pbOwk7ClHmHeOY6JH3ng2tt3WSakRZ/pKtqWAhuRJ3I+85L25pG
 Mg3LtqkMwT/IX7yG0WldBKOov5KE860sv1z7YQClhMByJt/S4ceh+N9vfKZbVK5sVaMe
 5kgZVyXgHIWQXb5bLj0fH+7H7OMg1Oy9Nx5HZLWmiaP5duuRjXV++YWt1A1unpAVfXvn
 gFQTsELqchfayWtK0oaFsgrE1mVrfAAd2gZE/GS37r1P9VR6G0TsgcIG1IlUEScUzJVa
 sFxyqhXuQjoZ82bPqRBp91TpHwvTqIa+ouTXNKC7FeBEJYPwhkI/BV8MZJ44m3ZQowur
 oELg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777363412; x=1777968212; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPudrdLn0IK9sImuSyJc3hr6uP5V/FxPl5nefsdVox8=;
 b=PhPnt1S4oUmKE9tFbjwldG2Vwa69RDigjCRCynn/xtiFsjy3WJ/0QWPY/dHhk6MT4c
 93fyKoDJG81k+leNWP2uptf1A8Y8Eqh5bXIQnQ9qktIyqV75Dgft7rF4BS4DI8MVOPNl
 SzL0EsTKuPzRzv8i709vBeEGY6Y6vFun0AQV5uNJ9MOCmcB+GlbaUFN/2985mqTNu9wm
 h/30U6g9PTXgMseWGiGrZ5XajDnvgpe76IoYaah5DA7SUnKE8Yf4p5rUjrVM+5nCJptS
 gJtzOLKj9MorRC3jzvX4APluUmj8QnRUBFxXqVevHoxiYNUw/7UXMLUmpyrXxMq3M/rS
 EK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777363412; x=1777968212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BPudrdLn0IK9sImuSyJc3hr6uP5V/FxPl5nefsdVox8=;
 b=qstAkKCidAMc6/0yUB3XSgbTKoSLoKHh1rv6UFLMWFQe6XCspYqtWXCoTAIPxSa0CF
 rJ8UVeKFyEV+QoUW18XQpNE0/R+7aMl6s9rHVMgsN3ZIpZXNyh/5XLzNA0lIWbo4zn6d
 CMx5PR1XLwJm2fH9G91v3nK+Yax5XUj2eFAwS0Fhv7xXgeaYhY64L4bGv4ktD/8Bjmh8
 vEVJIeMcc4xhfLxm/VFu58w1NfDTwiYR0EFcV12iR4GDj6or6c6GyVtAMsMOn9jlbXwb
 cLcUetJZK3TkJCwruqPgQoa0HbO9KXcKor2abOu3MTnJ8172N3Ds593Kk6h9mC51lex9
 GBgA==
X-Gm-Message-State: AOJu0YxVr0hJ0l+B9tjeeyqUHW1VEJFe9zQk3/pMOIkoHMfHHHErU1cW
 hZ2cS2ub86gl8mXLkMc5G8JvndUSvoquZ9HLGNlsTawTRFiUgMDvmS1Bw6VMgP4MDZTzW2rcukh
 UBgMdVth8+TlesDuavZM8O8OXsubHjn0RS0GURPf9XTnaDxOFPL8lJE1+ynK0GCd/ybukMdlW8O
 BArTE/9c23VqvML2zVZ6o5XZ4REsD45bE=
X-Gm-Gg: AeBDiev7f0GeNupZMoBloQE0jzVZYQr0VUNc2pJBoFg+YOXO4P0IsqlrwsmkO5S9NRp
 flVXGJ/pfev18UFQqq0dzpPVgMHkH1tWiOghHsDA+gkHc9C5TV4YOtgp9hr8W2YWTXybptN+tGF
 DpDCCnasiWQc1Ztb4z9QqAkEHhfr5EyggG5VPm46MGkZ1CH0TnN4UiwzIo7dyF/ZGpvasTyKbGF
 ga4ZdTQEX3Jit0ZdVysm04NThi/DYtw1SmdAuMDf5QDkvlL66+Agzaf0/OQze9ICJtt8FREKO7l
 9xhhAJnZcWCb2PdeO5Rm+xwSSqCp9qOL2tE=
X-Received: by 2002:a17:902:ebca:b0:2b9:6a47:787f with SMTP id
 d9443c01a7336-2b97c4ca07bmr19618115ad.40.1777363412018; 
 Tue, 28 Apr 2026 01:03:32 -0700 (PDT)
X-Received: by 2002:a17:902:ebca:b0:2b9:6a47:787f with SMTP id
 d9443c01a7336-2b97c4ca07bmr19617825ad.40.1777363411463; Tue, 28 Apr 2026
 01:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
In-Reply-To: <20260427-gtk-clipboard-v5-0-6968feb31a5d@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Apr 2026 12:03:19 +0400
X-Gm-Features: AVHnY4JXx8X6OCdh3KHq1F7XnSM5lV-4QyOKVnXosX8iaFpYR2uAoprjKHW3rS4
Message-ID: <CAMxuvazzhm5-HwgW=h_9Rd4DBChgKZTMMCNUby5S=WQPJ+f8RQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Fix and re-enable GTK clipboard
To: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 28, 2026 at 12:06=E2=80=AFAM Jind=C5=99ich Makovi=C4=8Dka <mako=
vick@gmail.com> wrote:
>
> The following patches change blocking clipboard retrieval function
> calls in gtk-clipboard.c to non-blocking variants using callbacks to
> avoid UI lockup. It is a follow-up to the patch proposed in the GitLab
> issue
>
> https://gitlab.com/qemu-project/qemu/-/work_items/1150
>
> This version adds a similar change to gd_clipboard_request that also
> uses the blocking clipboard API.
>
> The second patch removes the gtk-clipboard compile flag, keeping the
> GTK clipboard always compiled in. By default, clipboard is off,
> can be enabled by -display gtk,clipboard=3Don .
>
> Signed-off-by: Jindrich Makovicka <makovick@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Changes in v5:
> - Runtime option added, clipboard still off by default
> - Link to v4: https://lore.kernel.org/qemu-devel/20260427-gtk-clipboard-v=
4-0-176ad9919931@gmail.com
>
> Changes in v4:
> - Replace gtk_clipboard_request_contents with
>   gtk_clipboard_request_targets which can utilize GTK's target cache
> - Link to v3: https://lore.kernel.org/qemu-devel/20260426-gtk-clipboard-v=
3-0-09555aaeda34@gmail.com
>
> Changes in v3:
> - Use gtk_clipboard_request_contents to avoid text conversion
>   when we only need to check if the text is available.
> - Link to v2: https://lore.kernel.org/qemu-devel/20260425-gtk-clipboard-v=
2-0-b098f3cf69cc@gmail.com
>
> Changes in v2:
> - Removed forgotten gtk-clipboard comment in meson_options.txt
> - Link to v1: https://lore.kernel.org/qemu-devel/20260425-gtk-clipboard-v=
1-0-6bd99e708e14@gmail.com
>
> ---
> Jind=C5=99ich Makovi=C4=8Dka (2):
>       ui/gtk: Use non-blocking clipboard retrieval
>       ui/gtk: Turn clipboard flag into runtime option
>
>  meson.build        |  4 ----
>  meson_options.txt  |  7 -------
>  qapi/ui.json       |  6 +++++-
>  qemu-options.hx    |  9 ++++++---
>  ui/gtk-clipboard.c | 53 ++++++++++++++++++++++++++++++++++++++++--------=
-----
>  ui/gtk.c           |  8 +++++---
>  ui/meson.build     |  4 +---
>  7 files changed, 57 insertions(+), 34 deletions(-)
> ---
> base-commit: aa15257174da180c6a8a9d58f87319cfe61c5520
> change-id: 20260425-gtk-clipboard-fdf99db13ac0
>
> Best regards,
> --
> Jindrich Makovicka
>


