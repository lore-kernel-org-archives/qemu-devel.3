Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F8EC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7akx-0001PV-5F; Fri, 18 Sep 2026 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7akv-0001P8-6i
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:44:05 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7akt-00043z-Lq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:44:04 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3920so6467425e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789746241; x=1790351041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cexAuOEHyzsb7T5VuESWNM/x8j7S4muvGPwFa5qreCQ=;
 b=A2p47gGmxXFP2JZQ4sTCQ476Lsnf8YVz+jh+dRoRyXYufFb3LqnJKDM+9BnV7WbQAy
 /x8Do3pjsu/QIe5kz1hyPk9xQoyLH7FcYuHrEa3P5UO3yBa4oTDkM7A6aWTPMsGz0kDf
 jJjBxRrzn5OJ0f6qQe7vLIwyLOSvNEpCte+hexIF75wqXCGztnlgPcqGvSH+xD1KQoVo
 9OdUpE/c0a7Zm+VSPrNtzlJVmqvW6EjzE3Zo6Gc70iQLFhFUWb6smODQMhgCduj4n6Eb
 D+NaCuKpYrJBAivoggBH2enUUYSy9awIoiFOY0OZkXELIqVaOkTPz6fmaq8GFwTf2e6X
 XFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789746241; x=1790351041;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cexAuOEHyzsb7T5VuESWNM/x8j7S4muvGPwFa5qreCQ=;
 b=OerN5qsq+sZkZRT6tdnj56Banli/kg/HnSL6nIKEco+AV95Jf6zxokkxPOMvqnep7j
 gsCphFUPuyRLXLVDYLXJQuzKsDGDlgEI+qWom6bqU58ElWrEJKzF0Tc05Wx0YKzk8lyH
 Z9suAgNZPMgpM8YHR7PKyUdlVIaQYbAYhGyYOsuO6+k26xuEjty9aVHANchoP2mL90ge
 vnRMjBusRBxl7y1borXRpu2HwOBUZ1gcjjtW/meReICMGJJAWj1L4nlepRx+M6lMoEy5
 19cK7xFNfnzeSCQJtPCM0a+oZFNvcHMpfljvanxsFuHweM336uiaszHC02VGAzIqtW9X
 0xPA==
X-Gm-Message-State: AFuF++kEfcfPLg7fvnnmoCQH1WAg1BKB6C1U1oNz6K2oiSkO/GM4SuC/
 JNUcfHJBh//ARCfYf9iCFj/hjvVjsuolrzXgOQwLIdDs82yFiiKVO7Z1Sf2eD83ZAmDltQnEEuW
 8+PJd
X-Gm-Gg: AYBFou17ytNpaseZMTbH0NBE7MT1mHMbo+oCcEc+imLJQg85fwOGau0qIPc7CLOiv0m
 GgAsoC53rOgdRjHEksmypNJQ1WGI+qd5X7R78ZAIFdRkJJtkBGZji5oDy2gF818LkIRbJxDSeq+
 eRsFp0EK+8qKRKNZ4OgGs/SvF8WuPkmeL9rb+spv1YhqZlU+z9uKLNdITK4s0R/Lb8Mb3Cfjfu7
 5vxW/668zaisThdW4hJtizOXpRz5+cVVdlRl7V+zOBgj8tmOhywpZZYfwG2mPouUTAPtpWZnefZ
 O/AOuvG8u2qX87J+alJro+xEBLXnIhQ7tlVY5ZPOOyrrIDsD9jTKrCiFP5m6qT5tlAsLX6BNNVr
 p0QmuVceVZyePjgfdb5VVkAETtR5AVBqSDDysdB9YJ7Yuxc+lrMZX5dE54DqA0ajm6xcoAQGuDo
 vFpuUZ0bZF5gGF0uCxghNqL3/ow3GQXWSJEnrbnJfXM2sPEscyTqDjDjjj4zCkxDs0mdgphiLLX
 BpgjMtnWg==
X-Received: by 2002:a05:600c:c490:b0:49e:6e43:ef13 with SMTP id
 5b1f17b1804b1-49fc574122amr35188705e9.24.1789746241508; 
 Fri, 18 Sep 2026 08:44:01 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc8dde38fsm49629915e9.1.2026.09.18.08.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:44:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A2EF15F8B4;
 Fri, 18 Sep 2026 16:43:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com
Subject: Re: [qemu-web RFC PATCH] blog post: some notes on the bugpocolypse
In-Reply-To: <10111cde-7d2e-4e81-8233-4ae940a95dac@redhat.com> (Thomas Huth's
 message of "Thu, 17 Sep 2026 11:10:07 +0200")
References: <20260911173420.1581755-1-alex.bennee@linaro.org>
 <10111cde-7d2e-4e81-8233-4ae940a95dac@redhat.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Fri, 18 Sep 2026 16:43:59 +0100
Message-ID: <87mrte5zuo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 11/09/2026 19.34, Alex Benn=C3=A9e wrote:
>> As we've been going throw the growing pains of AI bug bots I thought
>> it might be worth addressing in a blog post. I'm mainly just trying to
>> outline the challenges and maybe dissuade people from spam bombing the
>> bug tracker with lots of low value bugs in the more dusty corners of
>> the code base.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>
>  Hi Alex,
>
> I was hoping that some native speaker would chime in first, but since
> nobody replied yet so far, let me try to provide some feedback:

I think non-native speakers are well placed to review blog posts because
helps make sure I don't introduce too many English colloquiums which
make the text less accessible.

With that in mind:

  Message-ID: <20260918141937.334849-1-alex.bennee@linaro.org>
  Date: Fri, 18 Sep 2026 15:19:37 +0100
  Subject: [qemu-web PATCH v2] blog post: some notes on the bugpocolypse
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

