Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F334BC5DF9C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wykcq-0006fQ-Oz; Tue, 25 Aug 2026 02:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wykcp-0006fB-9g
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wykcn-0007mV-SW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787639227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=if5M7o6La6uRDKzZyt5DBXUUm0UeIS6IBxLvLbHpdlM=;
 b=g8owDhPgILmI45OoipNu7Ho8T/FL4UphD98I0HKz5h3GwY7ZoIZ3ChyTP6H6EOQ5uqqsVp
 IzmCmJVMc3Uk84h895l+5VODcEe4FGEkPeFwqI3HQDzOYEFGHqKq42PtvD5t7rXMr1wlKz
 GU2bn0JpDFZfv9637r0nC5gu5v+91ak=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-mcqK0sjfM7uPGltL1KU6-g-1; Tue, 25 Aug 2026 02:27:06 -0400
X-MC-Unique: mcqK0sjfM7uPGltL1KU6-g-1
X-Mimecast-MFC-AGG-ID: mcqK0sjfM7uPGltL1KU6-g_1787639225
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbedf6e8a42so5324792a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 23:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787639225; cv=none;
 d=google.com; s=arc-20260327;
 b=SwOwJpbpI5nvh8BsOeObVanpUNYIeZBraqYaNZyf8Y4AC1WCCRiXYT0nFZdaSEJEsg
 RGS3qRDM3aLnYxmCjP6Dd0k5VXVKhCIPtLaFg5nYWIb8kd1BZ/WLeaQDX0Oe9uCFLJB9
 tV0gp3/gUCo+1KDuehNZAecugY1Ueq55AiNL+PJfRBkYDUL9uBLaP9rCrIydvsr9ZRiM
 +rCzQcIboSDXEd3YLpywrYbshEIrgbXaqmafYF44p73ifrspGN1nBKf/ylfsd8MwHSeg
 IayrGkrJZA+vZMOpgTmnlMbdAE0QHxAaM0TE610pNnExWw0Dno0jdu+OaRlNJQvG80gX
 waOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=if5M7o6La6uRDKzZyt5DBXUUm0UeIS6IBxLvLbHpdlM=;
 fh=LeMFk/UojW8fRl/yiYg4gM5KT8ogexHCob81ZsZuwr0=;
 b=QyB+8bWJS8X2Fm3ZSli6uPFdG0tOVq7SVPQ71u6jm1OXAojOcSJOjxf4XRSgpMOTrD
 2/PcAKzUyNUTJPe48OMVmGDxPOVLOGCGFde1Jfv6OzRRx+T2ts2XaaaOK69rNQ0WaRC4
 oJjGxNX0bjscjVeLdOLUy1p0wpKkQV7tltrHq8rf+Gy7EgXyU7hg6OrIni6zFrkn6nhK
 jryNaliRrDgdl5wd2e1s1EH1LAXZK9iloKIXU/4dnGg4ptIyVPitvLX6BaKYLfSiHJc+
 P7SupOfLAuUawpQbRAvlgAnJSl3mHoQ7ePkYY8VzsQjDqd9lH/7839t3aM3kA1YAHX0i
 aHEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787639225; x=1788244025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=if5M7o6La6uRDKzZyt5DBXUUm0UeIS6IBxLvLbHpdlM=;
 b=dIosoxMLu5FMDI6Y8x0r+qrR07af1C84FMZHlJD/mDkSe7yq472cX3wHIBr6TjpQF4
 oL0hmjF1xjRbnkRoumyLODh6Pfs1ZVGlRw0Tc3z3J/SIqf5RMT6oeV/PQz2HjzAQWfyN
 H4QG6GrczhKRP0oLPhf9HYQvwFBUPzUAQb/HC9IDVBWeAx9R60WUBGIxwF4Z3Q0zEXGF
 gNM5FiC6GFjnq2XhcPcGbKSAbfbL6W4XTSmm18jIGtYGnJEez/0mX0c2nCAdkBZdO7bU
 VD2wSPBVgI+8ZH7vyJFKiKirEgqym0q92Dg4rsiZl31ia5zSdUOUhsxFgYjRq2z0vu6s
 Fzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787639225; x=1788244025;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=if5M7o6La6uRDKzZyt5DBXUUm0UeIS6IBxLvLbHpdlM=;
 b=rKD4vIauJU3AzYQJdAr4Kh+gqzrb6XpCWbA1aMhhIt8It735Sl+Xdgqv/X3ZGW8v2K
 hpidW1PF8+xmq6qECVYc9Jh9jg3KZl68v1O4TZm2Y3ua5We8Mj/nxqcGnbIjbSC1LSDa
 FtP//tkduBHap02sB9UZMVu9+ldEh0iqNhE/D3v3YzbO0+1LEWl46SVLkdlcClS7QWc5
 4clyuTmlmyp2Fo/M535rTslap5GFagZ8h6tte32mXkaHYrjXSluUvxSXu9Fr7ZAkP4YU
 DzTxSYSCnWMkoQ9CflfxbIGkeMIpNr6F4gNNFXDsg9HmIK870KkkMRwIacZCKZkrS7ew
 SoTQ==
X-Gm-Message-State: AFuF++mavt/qKUSYLxkQ+CgcH0kfLJ2zhGna054T6CyzjJb2B8dybK+h
 NlcThfuO8TEgzrvzL4N89aCv3hfAwvPO3si7byK2EeCyQpQ+FbIcp62lVknmYQDSCCRxTP/9R9p
 /s5aEhQjp+/3e1smA/OHFdhKn6TVAhTkwpdGQx1e7BzK553H4bAMuHZMOMJQYAaAGe6XSiYN/ss
 ZljZJqiFtYq5Vne3aVRiOwIyA2QCHg1EQ=
X-Gm-Gg: AR+sD12T5GP40IfEl2IR9GsT7GuElHEtGN13wNynEVIUGz1k8z32St+mlIXwjOXraXW
 fQ5S75kI3c3iuXsBbxpDuBVbP8eezTtF0m9WUK6XQaqIVFfY/lXvzfGf2MsAPIZx2tc+9iGE70O
 htC72nAIIPkob+861HBYu6dg/v13r08C1WJmEBdK6IqwtdUluObrbY1ClAMIidB8Bk93BLrg4xX
 bn0i0DxsQJIbKY7IyTh6whFY3MrpUY/8G8koiL6drNiInlKLjtD+vzvuKxOt9MPBkIRR1+qSEGp
 1Q==
X-Received: by 2002:a05:6a21:790:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3cd300d467dmr64910512637.13.1787639225122; 
 Mon, 24 Aug 2026 23:27:05 -0700 (PDT)
X-Received: by 2002:a05:6a21:790:b0:3c3:7ac4:dac0 with SMTP id
 adf61e73a8af0-3cd300d467dmr64910426637.13.1787639224730; Mon, 24 Aug 2026
 23:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260825051441.1562454-1-jsnow@redhat.com>
 <20260825051441.1562454-4-jsnow@redhat.com>
In-Reply-To: <20260825051441.1562454-4-jsnow@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 10:26:52 +0400
X-Gm-Features: AcwNN1UMKHcBxSq7OEYp0pHYUG_8A_mMqWUzFjZpG8kVJh5qETJ7Pj5sPPKeNHg
Message-ID: <CAMxuvaz2nu5NF0HLMJ=gFPjF3+SnE5v6UQ-i3UX+sYA9W22xeQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] tests: update netbsd dependencies
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>, 
 Kyle Evans <kevans@freebsd.org>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Aug 25, 2026 at 9:15=E2=80=AFAM John Snow <jsnow@redhat.com> wrote:
>
> NetBSD appears to need 'bison' explicitly installed now.
>
> I am still seeing some intermittant failures in the tests for ide-test
> and qos-test, but those are mysteries for another day.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/vm/netbsd | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index b365045066c..45afe675e17 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -39,6 +39,7 @@ class NetBSDVM(basevm.BaseVM):
>          "gmake",
>          "gsed",
>          "gettext-tools",
> +        "bison",
>
>          # libs: basic
>          "dtc",
> --
> 2.55.0
>


