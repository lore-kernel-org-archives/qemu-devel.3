Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD4EFED3F2
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGM4P-0001ns-9M; Fri, 24 Apr 2026 15:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGM4N-0001mH-Q1
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:20:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGM4M-0007YC-5E
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:20:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so6021677f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058404; x=1777663204; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMYV/WLNG1IPm/JmsJtJ4aYuQn61uW6+qWXaYkbHZ1c=;
 b=ZDPU170PSaiF46VZmI9G7cuzPX5mNAMTSHbEGQ/ZZYgVDWYa1i1lAIF8Ojx2PJJVlX
 d6RIaMo2fQZU52buKkohVlIxbs5RnVUaWauLXUfzgBtTHcsl6eqsPpCT5N1Iy10BBP7H
 PZGmnuSHKV6pozqnC6wMuVN9hbl1iyBYxlDkgcRHQjQu3iFRVw3r3WY+d5HQekTKV8M+
 HVBiQFJxXd+v3XGwUtz4KxhxWnj8ud60QQGsCoVfHM7gtnEmU/ZP1kJRWDWgTFlHzgtV
 bmE55vDbN7CCmVwxn212KA5ZIKcY7Fy0nP+zsyHUWLF/S5kx34QOKuOawfulpn3l7dxA
 twtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058404; x=1777663204;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMYV/WLNG1IPm/JmsJtJ4aYuQn61uW6+qWXaYkbHZ1c=;
 b=WfBouQOzhKGRjeJNuujAKi4CbWAuEjjIKRuN8u/VSIi/M35PWwx58PhPF8fE0kAwM3
 zYlAiZkSPhWN8wzBI9nhfuRz5fPOFT7SME9ZDL8d7XJpRoHzYVxkUqmGUV6fuThYJFBx
 VoCEGew1BVDahN9Ur/V4RuTlSl+RXVa2yX+UCCRCdfpl5NuPaK/SpPQdVedBm8nZldFG
 D0In59FnR2zNXtOBBap8NJ3N8hrembBIW5ZOte6LSjS+1f2f5FrpWthjoK5jkzbU+sEC
 unjYj63bi4grviMo1yamrc3+8AV4dNDk5Od1cVAvDsSEel0NB30lZY+3+7N1+kWtQ5x4
 vv+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xwIEqXWN21c2kmiaLYbHzooixBYRH+liTT46g+ajnFpCpof89vrlTnHe6+uZLC4CAUVBXXo8nOADN@nongnu.org
X-Gm-Message-State: AOJu0YwzEJC7z+sPZ0OSCTzdfJiqAftHonaAequLhY4+hCpgjwPqOLh0
 iapjUxepLPaMmlDlt6DkKcBi4hag0lGBVlXISq1lfxDyyvtj5ZsajEKIjNdfVQZYyeY=
X-Gm-Gg: AeBDievri5sLAh2fVLOgi1sKU8xNMiY9FQdQ1PuSyhS9YeRMjDScpYjY8zxqVh5ShWW
 xHSlxIjfTAf7wmv6fu9SYQ9LOQELHnMIl9ayh8GuBcrS0wVG03UuBIHMEgtSzON20LVbEvGLAMA
 ghDb1CMi/2bGOxbZnHqu6k1aoYw3rB1heOjSa1JUzlChO2ilt06Wms+nsNxTchqyk7Q3nAjafK7
 35cQbLprPyLzOBxWT8Kem+Q6yLp0hjSHmWJePrNpDjZLJEOjXwxicFMnc6HcTuAQL1sN0ui41ym
 2i1lPqBrgSD4ecTtXNbCjsVmtrl1jS7zuH8XaSjjhmHFm446qp9JBqtHY2SB8UC+wS3K/uXgEhk
 lWOJEuFMjQ49GSUzOSbOYdUKxh2i3G40jbXPXCjgoiaHORMWNZGnS/bReJA89Jwxbi6cjEBAcgT
 UEbyCcBqk1tNYhP/SSPQzliw7puaO73cHVSj/EgpDb4K4YGhELv7EUkLDtA+u7M54KiOHuaaSLl
 bTr
X-Received: by 2002:a5d:5d84:0:b0:43f:e7cc:706a with SMTP id
 ffacd0b85a97d-43fe7cc70aemr49718145f8f.22.1777058404364; 
 Fri, 24 Apr 2026 12:20:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm65626575f8f.30.2026.04.24.12.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 12:20:03 -0700 (PDT)
Message-ID: <e832b016-0b55-4f27-9bab-51fd0d983b9d@linaro.org>
Date: Fri, 24 Apr 2026 21:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call 28/4/2026 agenda items?
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Demi Marie Obenour <demiobenour@gmail.com>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 Alyssa Ross <hi@alyssa.is>, iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 jacob.oursland@gmail.com, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 matthieu@minio.io, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
References: <874il05rwo.fsf@draig.linaro.org>
 <ce906d97-7022-4671-8590-2f8f58b098bf@linaro.org>
In-Reply-To: <ce906d97-7022-4671-8590-2f8f58b098bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Using Pierrick new address this time ;) (Thanks Manos!)

On 24/4/26 17:40, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 24/4/26 16:55, Alex Bennée wrote:
> 
>> The KVM/QEMU community call is at:
>>
>> https://meet.jit.si/kvmcallmeeting
>> @
>> 28/04/2026 14:00 UTC
>>
>> Are there any agenda items for the sync-up?
> 
> I'd like to have a discussion with Stefan and Pierrick about the
> possible improvements that can be done on our CI system, and
> review our git-forge use in general.
> 
> Pierrick: Stefan is available this Tuesday, are you?
> 
> Regards,
> 
> Phil.


