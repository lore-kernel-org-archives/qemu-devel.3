Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F209C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 16:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7bdm-0004PT-9C; Fri, 18 Sep 2026 12:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7bc8-0003GX-U5
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 12:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7bbt-0002hw-Ve
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 12:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789749528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iob/v8MEurfIv16p0B7+BovUBK/5QGU1Hs0b5rPf2bg=;
 b=dr+yZzx8XiFI7NweuCxKC6azBPne/nRfpRByaLE39oQnuQGrtpn3SwH3ofOvls8bzfFETb
 bWBeSYHuXVVag5QRhqLIgvZPbEXJB1kz6RrYrNranfnIgiMRkA02W32L4rVPXiqa27bbPB
 Xxs3jq/YzBAtvfk5w0L2Tj15ISqd1Sw=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-9ifpM3HCOvOiyo83c4O4JA-1; Fri, 18 Sep 2026 12:38:47 -0400
X-MC-Unique: 9ifpM3HCOvOiyo83c4O4JA-1
X-Mimecast-MFC-AGG-ID: 9ifpM3HCOvOiyo83c4O4JA_1789749526
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66c70fa2ba4so999035d50.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 09:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789749526; cv=none;
 d=google.com; s=arc-20260327;
 b=P0uczQEOR02u60f1SOG2F3x45aw9RBlJGe65WKWeyT++ggUt74ldM5YBLndSntDHsa
 gUzYqKuRFpZSA0XDHY7jL/a+fPuj4K56As4AeZqqJcw4WViGRxXGbi1WdgWFub30rnYe
 QA0i+pjA0Sq3wt+k8LUh/mmlgsiY/kqn1DH8Qm0pn4ZQmXYZJNY5lvoOLsSNu9tWbCN/
 NXFR9off6BqwMuH0g+ticeyJq/uVfDmnsBVdptM9TdV4EjnEIm1TV9/rqZ6S7UnRg0sE
 DFPqbzLy+6YvHvA8DYQsCs1fDIOWxCGhZDOxLm0uTYQCx5IQIvRyfprrADnzYc2+92Om
 A9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iob/v8MEurfIv16p0B7+BovUBK/5QGU1Hs0b5rPf2bg=;
 fh=uZd5+b1JCK2ZTU/ucoTGda0E8G6kz5a596uqoTpd8lQ=;
 b=lqgNWLteuOc/cnGERz6H0G3kKmu/T2k7Ta5agrI9SI9VFhvu56BysE7ncqFrWgip1r
 ZBD8wRhSxLpmQFf1CvSbVAGtebZC6/Lih5XnHIDwGdxtB7YQFagj21oh95A4G0eERgiD
 vhntgkcKUF/3/2D2ohQLiyCM9qxFxYVvIwoNISo/P7SrpBIzEelTHzTKnDCyrkSHij00
 hMJOEDViah4ECbN3nN0fheXgP0lX9f30+3+HkgYgXlx38pNCY1s5zggqUxbKFFvEHWij
 sXUidrfqJs6ShkK/ELqrSOuyyM0xgR7JmKTXtMZNG0udHelki1YM4z9Du1PgBWPlgIk8
 90Pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789749526; x=1790354326; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iob/v8MEurfIv16p0B7+BovUBK/5QGU1Hs0b5rPf2bg=;
 b=OfRPWQFVXkX+OTjgH+z1+kfRXWwAOVncZxuSqGUI1dkVModvXcCIbEDUT1RTrNjXfa
 ZETICdEk40UMMu6LtD4YR39KC5ssXuooa2bu42lkD/KvGbI04NLm26n1sbHBaLBaQo8x
 Heusz0ud2ACFsGmwwVdZUYF4X9x/lnxzVqytNLd+9VX8filSxgFyaJJFOPtQmlLhMcSh
 kw21WwvRCpBecLbNE+2BMSh51bzsnk3InWpUaaJ1KiaC3ezcvGQqBjJIGzypA/iGVT7d
 75uaHcvOyodkNi6qqTCYwqP8eIk/J6riRMY3askOXlrAjz6Hkb0bNmlKrimYESELE87w
 MhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789749526; x=1790354326;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iob/v8MEurfIv16p0B7+BovUBK/5QGU1Hs0b5rPf2bg=;
 b=YoMx4wPsQ4VC8/QYfl/XbdwWUj+3XrHYEMBxCyI06iTD43cL1JpgGs3EuFcYqVHMqD
 x20AXVNEaNgfCuk/krKUEngAt3M+YmOL6qzoQzIc0r/7ppmkazk6r+rz+YEJT3JkrGva
 jqUeTImU6U53IjbU7jF0w5qwl/Y8kVcn0ST3n3Ttq+spQAlsLLYU5RSgk1AaZMrPpAIr
 SYk4RmwwWEGzJcCUrsTs1QWZRCaHT8lBiu+cD3z9e1n6JKBh7/utfJL/dolmnn22fXOY
 CO6h3UUPZlXPd2WQE1CxQ8dU+xgDhnJuqS4KOjH7NnQNhIhB+ySofNFYCxgPt4naIkH6
 ETYg==
X-Gm-Message-State: AFuF++m2yVUdA2BnnrlQUvoLZFYLv9NYEa2emIHpiczYjpFT/hmGf+94
 3qoeCtd/+sRQEZ5rzYUOTzv3stqHrN0MrqJkYaAANTr+In8VSBW+XQlbTQbP6fef258FxcNZMzq
 7FCUQ3C8JNsruMxHEhbuM6dgIgRmZyIw92mzHgeMdDrCRFtC0/+B40hyhbUbgZ792hATPOyU8J2
 sfnNSDuFQ0TjEW3pn8z7E2MU95vvAZygk=
X-Gm-Gg: AYBFou3DHIBjY1Djvj91wuf+31megGw5TcR37HTS00APSWQR1A1Ek+tRG+97X6ub9Sn
 7RIaL1+zTTjz5d8kKdpBA9p5Y6QjuYb7HaFn4F6ne1iVazZLnbgZjwcHYDdCWP12Fqosa1W4Ub1
 s832PVKHDDleSrrOILplo8T5Ye4dLxYtxRTxbIlO8lRVmzHYpeKDB2gKnFxfAggcDSsYQmp8g6L
 N52h/yJ51W8hbF0
X-Received: by 2002:a53:ac92:0:b0:671:2a73:3077 with SMTP id
 956f58d0204a3-6717faeebe5mr984907d50.0.1789749526245; 
 Fri, 18 Sep 2026 09:38:46 -0700 (PDT)
X-Received: by 2002:a53:ac92:0:b0:671:2a73:3077 with SMTP id
 956f58d0204a3-6717faeebe5mr984901d50.0.1789749525816; Fri, 18 Sep 2026
 09:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 18 Sep 2026 12:38:35 -0400
X-Gm-Features: AcwNN1W6by1xo7V8u0DMNGg0FNmsm3LHDSdHzSBQLFz6xOPwkfSTq7K-fM2k_kk
Message-ID: <CAFn=p-ZHdCGWdxN7viafrTybhBzm+avpPc5tDfg=cd9ThmXYDQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] tests/tcg: fix more container issues
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Sep 17, 2026 at 6:11=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> This series fix tcg tests compilation with containers.
> It fixes SELinux hosts and dev container with rootless podman.
>
> @Alex: it's based on the v5 series and can be applied on top of it.
> It can be added for the PR coming tomorrow.
>
> Based-on: 20260917165602.3405537-1-alex.bennee@linaro.org
> [PATCH v5 00/17] testing: various docker clean-ups post meson tcg convers=
ion (pre-PR)
>
> Pierrick Bouvier (3):
>   tests/tcg/meson.build: fix host fs mount on SELinux enabled systems
>   tests/docker/docker.py: fix run command with $UID =3D=3D 0
>   tests/docker/docker.py: do not add-current-user if $UID =3D=3D 0
>
>  tests/docker/docker.py | 16 +++++++++-------
>  tests/tcg/meson.build  |  2 ++
>  2 files changed, 11 insertions(+), 7 deletions(-)
>
> --
> 2.47.3
>

Series:

Tested-by: John Snow <jsnow@redhat.com>

Thank you!

--js


