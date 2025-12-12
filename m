Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0451D4417E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 11:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU1HH-0008FT-Di; Fri, 12 Dec 2025 06:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU1HF-0008F0-Km
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:25:37 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vU1HE-0003ZR-79
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:25:37 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6420c08f886so1385625d50.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765538735; x=1766143535; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxqKg5s8Al0h2fuMJwkiYl9DaPZKPgEyWkG6YU95v3I=;
 b=KtI9wfq8ju+pWlV5q54N7Wi+5igYeBc87L/jrCV6VYOJVRYXq9UI6evylfskVl4lKM
 IlCZChvYuLCDEBo26glVcfnFZnQBLdCrao7KyxIip5eI/5acJqzntdQIt+7Jh31CWFWr
 2Tq/o/ilZ7fBveECwU6MSp+Hv7QxGLCSfN4u/CU9eGbHyfEgYlIggZBYxjg48a0Vaa2A
 lCfIdPyY08tPHGElxXNkh7LAkmpw1mAlyEptf+6PNd4cvN2MVSyduaUaelK71WePCkxs
 rNGL3NiGDCxE8ZJ0+r2ZjnekT9cj1HcnuPjQrtGdBRSbP1M+fxvPJt2Z96xDZeeH9vpx
 51Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765538735; x=1766143535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UxqKg5s8Al0h2fuMJwkiYl9DaPZKPgEyWkG6YU95v3I=;
 b=U0DrELemP1Z8p80KueVJg9UFygHmCZlyPLkgtQ5cqr6Cmc0dE13yHiKYDQtgS6MOrg
 ClXmjnJKRv96k3KP/tozfV53Obybq56inPcqHAtXLEhFhXUqFt5Y3o8k2b9hMohRk7w1
 omOnbUhUNhmCglPkhyYHspYaMzED6z9LkoU3ZpIwFrqbuMLBScwELMn0cYXQkIJRH224
 ooRSQfaqMNPWujUeL39rWuA0GAsJEbh7GG0c4sfYyRgrGPcKwlkbcnW43l0p6ZEKopBw
 QdxbBnsEDgvrvw/60QO/wiQBCrHHaHiAsRlA3wld/KbiGC6ZNSFR53yzem5DOwD3BEde
 KnPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVyiNgI05WFgi7d2Qg0pGsz+1rwGfTiqQw1emu1SvgOmuuCtwr+Sy1yfrIvogRTScCLRaBj91WWH0E@nongnu.org
X-Gm-Message-State: AOJu0Yz9zmVKEEPq+RW/fq8Uy7c7mCC6OpYVf4hJPFfEzNC3OzOroz7G
 hcnh1MMmna1xBCGocEVqGcBi88JR6tjtdKTl6LoipjM3ujy913yRZiGsKs7hrdDTLTNGKPGJu2l
 FF5KqCX+vjLBXCQxsni13Px1eTkZSvPtiqiqzHT3ZBA==
X-Gm-Gg: AY/fxX76C6l78XHFvBWHUVDpP37yzqWRSDJ31lDO3qN1fChHXPdGyD/VG0F9NMJKKfy
 FMcHXzFldzqw7jzJeZ7ngJcHz8CbCl2Kad6DPvr5c6E/fhY7+zAdgH0bi5l6HO9wwmICHvD5Ihg
 RVQv8oBWSVQi2G0GZ+qeZ86keaRs6rferxUYxwrQs3ivawo4Y/umHHV5O514+aeCeLmMXbhdl5s
 1zeVIdeNs/TUZMkcAFQnKxEVCwLHG+WKRUaoFbEK1mgtrdr7jL7fkZgLDJl9PECW7uSh3Fy7tHb
 yFUF7UY=
X-Google-Smtp-Source: AGHT+IH7cbx7kgSyF1N+bhXCiFk4Jet2Ymw60Y9+2A/ty+gvs6SsVq3zmDGxdHlmIGOrIsmB0gU4mJ5ENgaMjrjMkuA=
X-Received: by 2002:a53:c98b:0:b0:63f:9b89:8893 with SMTP id
 956f58d0204a3-6455564f1dfmr1191874d50.52.1765538735072; Fri, 12 Dec 2025
 03:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
 <aTvPDXZjfp4_egTa@redhat.com> <87zf7ot170.fsf@draig.linaro.org>
In-Reply-To: <87zf7ot170.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Dec 2025 11:25:23 +0000
X-Gm-Features: AQt7F2o3P_wI9W0nHRsnnWNobQehUbrYnho0Vt4J-eJAI18Hest3x-y8Zt3U9Dg
Message-ID: <CAFEAcA8X04aDqKO0S1cq-7V=4JbjaRQ4CTQhPh8CRxUKMxHE6g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] for 11.0 conversion* of get_maintainers.pl to
 python
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Fri, 12 Dec 2025 at 11:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> We can certainly add the ability to dig through git but to honest those
> doing archaeology are probably better off reading the logs. The default
> it just to match paths to MAINTAINERS which I think is what the main use
> is. It's not called get_git_blame_info.py ;-)

The default of the existing script is to start with
MAINTAINERS but to fall back to looking at git if
there's nothing in the MAINTAINERS file.

thanks
-- PMM

