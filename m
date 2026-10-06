Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A819CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAJ-0003WW-3Y; Wed, 07 Oct 2026 04:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEIAZ-00020O-0p
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:18:49 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEIAO-0002kT-Uj
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:18:13 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6e560e00a86so826856eaf.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791343025; cv=none;
 d=google.com; s=arc-20260327;
 b=XOKBUPdEXt74baxXU9uIiX5zbiXBMLfUkqxYd4YdEBaOwcFCxKFg45hXXF4JCrvAXp
 AoybrYQ6M6z1kp5Vjyg3wjmI49Uuy5wheajlsQIWJCT1Z6TmgNulkks3DF+zsIM4P8kV
 nN+68CsSJvxQcAFVyX4ZEycqZqsyKN/K6CnL3FntHifXepqEfRSYfQORKNR4KULwIv++
 /AFqvehPOh9VryeJ3U71Jv3o4mIZs3/YgtfUO//XuSQqHDUYjZOvNM1/u9DkqcgrVlnY
 84VXQEwlDmXYcwQLqje7Bnjdvvh+2s5fEo6iRo5xYfCJUNlYUoO6k2aRkacPzbBXW/uS
 5uHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4+Kbw5l1QvEF9nvw7bEAgKI4dhIQ3CcnfTo1SxWTlDU=;
 fh=G4JQhXli0ItuDzMvyP2ZyKoitiRMe3+4SWqsqIaQMMU=;
 b=cqZ9de+H1MJqO2rXeLOwMyN7yf3QuG26X3QHhE7IGZjIatR3Jcuk0M156hXhD+exGi
 mpdpba8+yyWH5MhDB1UcMoAgOvW1kjxcIRZQY57D6I+91Q5rmW6+q/a268ewLFnpsCjj
 tNWCHYqS0wd7THBPsh3CJpv+rBmsmZAQRG+rOwBkOjS2h4M8bn91FXGiYxBAXCAvtfBu
 jgr5TGo1Jk1QzrMfOWanFDzaBeNZXoS2bHw6/oM6iquqzhwZm1MDAPjYe3o05wYM56x4
 vOImjQMc4gEVABwz7KZtJAyK7Fvbls9c2Pta79Txk9cTsToHwnWgw8qmYQEyiglpW/tZ
 kZeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791343025; x=1791947825; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4+Kbw5l1QvEF9nvw7bEAgKI4dhIQ3CcnfTo1SxWTlDU=;
 b=TwE+/L9sZXmz1mG7ietGkG5hzl6xd2FsMYmlKXl2ZUkVwiDFJs1JHdvVhN79NLaYRS
 /y1w2GebAaNbN9A1gQybMYCoPf4X/UKlQEeXLsaEjBh3JQ8G6YTdCUXyv4LXXo7YaCk9
 8Tme+zR7CtGJ5/lZekjuYuAvhXigEeDwlUlNqF7VNIaYU9f18iK9JDfCVHUtxEu5p2ig
 RLmIKad8rWSi72BAy3rT6CFBtqnZR1WdioGL/6fpt8TnImi68jEAcawp/x4rmxFv1j5m
 x0HuzHk/xFy8XR3gx4r4m2+muDg4SB1/pgPsNAsFoo5VaZqXw210YROqxmf/fi2LPVwW
 6mWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791343025; x=1791947825;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4+Kbw5l1QvEF9nvw7bEAgKI4dhIQ3CcnfTo1SxWTlDU=;
 b=J5W64qNNdzQFv39FoQ86aXKd+i6iaiqfhxhabncK03MBoA+l7nID1sdO03LVyZc7lZ
 rWgUF/J1FVJH23CTKq4pp8wL7az2Ajk3vmHqTWZ9r8wsBJoVomFMQKtk20BkF65XtutK
 xO2tDp2cAufZLSIX5ndRAJo+tE589E559GfmMQWTdPOmtAfqlwx0/bKYsBuw4RQgccEy
 NHZyH679jGO5htsZkKwt/hmF3+JIFauKOMQmuN5DPVaSS5lw+ADooY3m8wVKPQK0m4dI
 mEaUjEGdPmOfyW/IFRDR83XokEsoHhSVF84bhtwqOyO4EBHr2eaQsRDyPC3O91VzOyHX
 vyxg==
X-Gm-Message-State: AFuF++nrKDEXiA4Pe9Ik+IxCAaiK318onl0/K9JdzBEowXzuJNdgDA0/
 tzaxvnlkWwA4oBKfkMyIkYBbxyDhShsvj9zDrY5X3gIA3cOpzu9YQBhToJAaOQSJIzex1JloTuS
 l8x1Z+0jpb0aoU5iyRRsEL8eS93v4gnugXGb+9ViPtxeAPLstyrPj9dEBFQ==
X-Gm-Gg: AYBFou23PqBfElVSzGX6Tjr3EHj1ZiUieLct9g9GBOK9qgh+6HDrg1TB59G9oCbgBzj
 9D3WoDjXaZgHbblW4prXjsOG7lApxuDER1bBUHrslWB8FWwO4lBYA1jX+Zu0vBAheWDL7v1pOFt
 jTaeX4y+V7u+AoyYZxnhMOz1bk2UFnfjtzoChE0qvPOkdBECv/ICXTA7GGNkA8B2V+I3W4e7Jnl
 wWDWYA3GAE79dUYYT5uzGQkvqxBkQzJxRGWPBnd2Twt8f4Jdjw+nOGCy6QTP6b+ANBdXola2Xts
 LD1zv4WwGyjPkW3JomnqXmQwPWWiESzqMPU0ehhMMsKlRlAHRsNOa5y0b9Ob9YlpnfiiBzfy6V6
 Ql7SIG5ZzGYUMWdFl3dusZNVJzi7VhxMSQwZa70g=
X-Received: by 2002:a05:690c:e650:20b0:8a8:6fac:21af with SMTP id
 00721157ae682-8b04f43b92emr2467587b3.12.1791277589848; Tue, 06 Oct 2026
 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <1e5b1f1f-1d7f-43cf-8883-0e0ab2ec88ce@gmail.com>
In-Reply-To: <1e5b1f1f-1d7f-43cf-8883-0e0ab2ec88ce@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 10:06:18 +0100
X-Gm-Features: AclHuK99Djp35ASDUw3LzRuQ6eR_upCRkvgtxgzmLLmztnNWFp2XYPp_Mj3GsGM
Message-ID: <CAFEAcA_pVpXW+8g1tTY0dyJdXXzffO7sn0gqMZMBsc+SgbPu4Q@mail.gmail.com>
Subject: Re: [PATCH] hw/display/apple: Fix obsolete PGDevice function
To: Yundi Xu <yundi.eric.xu@gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-trivial@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On Mon, 5 Oct 2026 at 22:52, Yundi Xu <yundi.eric.xu@gmail.com> wrote:
>
> PGNewDeviceWithDescriptor is obsolete. Replace with
> PGCreateDeviceWIthDescriptor.
>
> Signed-off-by: Yundi Xu<yundi.eric.xu@gmail.com>
> ---
>   hw/display/apple-gfx.m | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)

There's a somewhat more comprehensive set of changes to this
device that include something like this one already on the list:

https://patchew.org/QEMU/20260916100021.73825-1-mohamed@unpredictable.fr/20260916100021.73825-6-mohamed@unpredictable.fr/

thanks
-- PMM

