Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C7BCE8372
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 16:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svJdW-0002lr-8a; Mon, 30 Sep 2024 12:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svJdO-0002jo-Ez
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 12:52:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svJdM-0007gp-N7
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 12:52:30 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37cd26c6dd1so3538291f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727715147; x=1728319947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7+4LyPUn3BSiPp2jA9MzLm5uuzh2ViMS9BZ6fxN0i8=;
 b=LfNu4/FJA6qeLwC/cDbknzAyN/8akCQFVgZX+4OY1+6d+07TvrhRaDdnIa42kHsGVw
 bDt3c3MDrDJ8I57BgOormoOaW8vx13UsxQRdKPsjNU1QFisoqAO7LKeXUyW4yWCw5dT9
 fWSgMbeUdlDqXs328+RC67rolx8Wy9A6D+Ivmo+rUeuWaCVJj+B9Q7RQ+ILlQebnBiDg
 pSjja2Tub2cVQiGnpZ5FJjoy4rczmQPckbqxWKOYVpvZiwrmOOFDIDnB2u7O2TIPxof2
 7q23IEHB8roZAjkNXaoVyEO77vdiVegdzsofbHg99vGsn/bQmSZiJxfURurzVShdsVKt
 VViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727715147; x=1728319947;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7+4LyPUn3BSiPp2jA9MzLm5uuzh2ViMS9BZ6fxN0i8=;
 b=SrflZ2U0ALHHI6PGEsxvI+QpjmX6DU1znryt0r3Jusk7uYwUok2lXUqmptUu/DyG79
 lxHHZ6+Z9qcnzlTd8H33vMwUMYqWRCeiPbTKIjTLcbK9KPoML+b7VNBgwivb4b9bKctf
 ezWyRdkRnv0S5DUQFvsdl4y/OMzajGFfEqLnen3dNNYSHLnKlRay5Sjp9sQQ9U762tc2
 1vjJ/0Cxazxx7O5UUDLBQoDtCY2UzrezVAcK9vuTH4cjpfHqKfQCBkfL19a5lGE63ZXm
 yoQ8k5zd+eqO0Dn5zjO5bMySM+dJST9PTxxUqu3ZQYDLmdQolYNxG6E9dYd1kcEyvp6D
 ceSw==
X-Gm-Message-State: AOJu0Yw5BXqSnTibZP3H6VcjFgRec4mo61kCMoTT1yTNm+yGpxxUIpQv
 Jgnyo3eH8+6cx5pliBLDy2/9gd7lTazupyXM2Ic+l1zNRgS2BMACWOmosr1yPOU=
X-Google-Smtp-Source: AGHT+IE4G9d3Ebu2tYa/ufpssUI5xng2Pol3VFzB369BwSoI2SdH/+Sef63AzEmYIndvs/KzD5BzNw==
X-Received: by 2002:a5d:5708:0:b0:374:c3e4:d6b1 with SMTP id
 ffacd0b85a97d-37cd5b04daamr10634795f8f.44.1727715146737; 
 Mon, 30 Sep 2024 09:52:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2777be5sm567176866b.17.2024.09.30.09.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 09:52:25 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1DCFD5F716;
 Mon, 30 Sep 2024 17:52:24 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Thomas Huth
 <thuth@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org,  Ilya Leoshkevich <iii@linux.ibm.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost
 <eduardo@habkost.net>,  Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  David Hildenbrand <david@redhat.com>,
 devel@lists.libvirt.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Elisha Hollander
 <just4now666666@gmail.com>,  qemu-stable@nongnu.org
Subject: Re: [PATCH v2 14/18] util/timer: avoid deadlock when shutting down
In-Reply-To: <1f749bb5-66e1-4ad2-b9d7-b31bfb7327f2@tls.msk.ru> (Michael
 Tokarev's message of "Mon, 30 Sep 2024 19:16:45 +0300")
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
 <20240916085400.1046925-15-alex.bennee@linaro.org>
 <1f749bb5-66e1-4ad2-b9d7-b31bfb7327f2@tls.msk.ru>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 30 Sep 2024 17:52:24 +0100
Message-ID: <87h69xnkxj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 16.09.2024 11:53, Alex Benn=C3=A9e wrote:
>> When we shut down a guest we disable the timers. However this can
>> cause deadlock if the guest has queued some async work that is trying
>> to advance system time and spins forever trying to wind time forward.
>> Pay attention to the return code and bail early if we can't wind time
>> forward.
>
> I wonder if this is another qemu-stable piece?

I guess. The code that causes this particular mode was added to 9.1.

>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

