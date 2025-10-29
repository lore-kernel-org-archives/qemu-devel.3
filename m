Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79AFCCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE16Y-000276-A0; Wed, 29 Oct 2025 04:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE16U-00022H-Oj
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:00:23 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vE16O-00036W-4p
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:00:22 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b6d3340dc2aso216165566b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724809; x=1762329609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lo/fkvxlatZ9ZM7K5APZJjivH8SZkSuHjrJ5IcMH1Wo=;
 b=Vx9KIc4OvfQ00CEJcPidNisvxa6DDc00VTqSIRuOr3AN+oh7E2BKiQkht8jeqMoygu
 AYDuu80oa8bp/Oa/5xZqBvibeBmzBde6aAXjM7QtL91KXABP3/ODGoB2ydUhK6S4E/bH
 GGwzWNLJ/QvieW3hDZ0m+8u9FR05vxIclQvHu/6rsDCJQ98lj6GB8uBUn2Oo3eghWSwK
 HL0Sz2vR5HVjLT1T6m4LlCaFKWf0OEmr5N5F98FTaeG8eV6weZxkwU3PXg4VQRUixZ7K
 WSYWtQsACF/VPrym0NiIsA519EF0b0fkathzqUzKN83uohMl7OBDPNjWu9sDFw8P/qKo
 sw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724809; x=1762329609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lo/fkvxlatZ9ZM7K5APZJjivH8SZkSuHjrJ5IcMH1Wo=;
 b=RRjoc1I/dvTjenSn0pHv/R3cPqW1dSsUwM3U9UE8tGSgvICR+Gzp/fsJDO32fyThZx
 uYkOHyhKuoa024e1UT0zYC8YbyvjzBgQ7YiMvCPOaMhM0/sVauqtFBcOXlysOcxL+1d/
 GcVChhBJQbBLhFcGlx3N/EJEHhqOTbDhEEPaa6IpCTc7xXwTU0sNZU8OKwwZOh9Al7Bk
 eTfkk4FX13v/iFbN203TCwP2/QfYBqSKedJDat3EL+cCtXn/Tr3eIUaabmTU+wczSORh
 dvp9/AsPKXyWdpdU+HfU6HHPOR+/YiWFTC5XqPu8PfZY5l/5SiyBLFS6F/Fu8TsapeNh
 S45g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4EFvNvmlvuKLkci5WpQnWtVeXRS0fQLVTrQ40lePPnQCs45cro8DHXl+b4lh5dOKr3xoyvDDKjFC+@nongnu.org
X-Gm-Message-State: AOJu0YxU+9R+uIYN8uWsCc8ZAz1mMBnMe0SHYxR8vdlyKrtDF3vjO7Wh
 xguxKwopQbu8cgG+syZxWl5pfL3w82kEdZdmYrzyvu0Vp4v8FnTwMeeNRJNz8s2FGJ+GHH9WpaC
 vPovtHcZqcwuQhg9Hr3z0LN19H0neuPjHjnZkji7+9Q==
X-Gm-Gg: ASbGncvLVBKOCjPB95OyCwGuxk+UIDsdnIDHM8wEnP26AUQfyirUUGu29lMS7f965x1
 hJwamLAuJDfC1jFspaSDizZFVTL8hzbCxNlQAKbJ+12qbcEk91kYVqY3kjwus83fUEf+/HuS3Dx
 LCh/G739csWNRJqm0WHT/lyUbf9f8OQIiasWx2VUxqVORvXYRuxE0634WO7EWguL4OrZJStHknj
 sxzlffcLNVYfSmOfhMerj+ggj3E3gMqPbG5oxNUceShWgnEr3wLtN1z++tx4xwJ0zdfbw0=
X-Google-Smtp-Source: AGHT+IFjn45/OHUwuBV7F8oV82cyrC2Qo98Ee5FPkabo+9A5VXgMJf0dVDNh3S1APrme49lheLiizPGOHhGPorkAkSw=
X-Received: by 2002:a17:906:dc91:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b703c15215emr220748966b.16.1761724809228; Wed, 29 Oct 2025
 01:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251029075342.47335-1-thuth@redhat.com>
In-Reply-To: <20251029075342.47335-1-thuth@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 Oct 2025 09:59:43 +0200
X-Gm-Features: AWmQ_bkiEOFyYcFWPDqmF2uJs0au_ErqgZwG5na9Z6fWKNK4grrZvEHfF8Ts1N8
Message-ID: <CAAjaMXYSHKM8rKizqjuURiaK7p0prs=ab+Gd_mC8skSRJ0RaQA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/x86_64/test_virtio_balloon: Fix cosmetic
 issues from pylint
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 29, 2025 at 9:54=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> From: Thomas Huth <thuth@redhat.com>
>
> Pylint complains about some style issues in this file: Unused variables
> should be marked with an underscore, "when > then and when < now"
> can be simplified to "now > when > then" and expectData doesn't conform
> to the usual snake_case naming style.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  tests/functional/x86_64/test_virtio_balloon.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tests/functional/x86_64/test_virtio_balloon.py b/tests/funct=
ional/x86_64/test_virtio_balloon.py
> index 5877b6c408c..7a579e0d69a 100755
> --- a/tests/functional/x86_64/test_virtio_balloon.py
> +++ b/tests/functional/x86_64/test_virtio_balloon.py
> @@ -66,7 +66,7 @@ def assert_initial_stats(self):
>          when =3D ret.get('last-update')
>          assert when =3D=3D 0
>          stats =3D ret.get('stats')
> -        for name, val in stats.items():
> +        for _name, val in stats.items():
>              assert val =3D=3D UNSET_STATS_VALUE
>
>      def assert_running_stats(self, then):
> @@ -87,10 +87,10 @@ def assert_running_stats(self, then):
>
>          now =3D time.time()
>
> -        assert when > then and when < now
> +        assert now > when > then
>          stats =3D ret.get('stats')
>          # Stat we expect this particular Kernel to have set
> -        expectData =3D [
> +        expect_data =3D [
>              "stat-available-memory",
>              "stat-disk-caches",
>              "stat-free-memory",
> @@ -103,7 +103,7 @@ def assert_running_stats(self, then):
>              "stat-total-memory",
>          ]
>          for name, val in stats.items():
> -            if name in expectData:
> +            if name in expect_data:
>                  assert val !=3D UNSET_STATS_VALUE
>              else:
>                  assert val =3D=3D UNSET_STATS_VALUE
> --
> 2.51.0
>
>

