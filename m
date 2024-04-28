Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3889EC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CxX-00067z-Ds; Sun, 28 Apr 2024 18:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CxV-00067h-Vj
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:25:22 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CxT-0007MT-Cb
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:25:21 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a55bf737cecso449995366b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714343115; x=1714947915; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ya0jZ8n9WJjJorfzw4j1dNGZnshBnu+wocUnYXirx1o=;
 b=YxtX2VQZt2UZfr7+S3ex2GAMbSF15q5BkApZ7DkT9o+ohR04ByxxYSKbLiJIoM0iKS
 yYUc06L6DEw/EIk+APlWqXk1DavpnGHw8zIvbbQDIEm214OO8QNuCvYH9zZRQcGH6iLI
 p3/hvctz313x6/BSyncSicSPY9ODXM0hn4vgNye6q2RVeUmHaN6aF1l6ZH72KhRaf1QM
 upqzcyDoqiHTyrmyMKxbVBPKv8z2cpPBMsZ+qJQAEtAGdk1lbPXy/R3cBpZJvoqv/yp+
 1aBcNOWejux7jvVJLV1Bn3dBO1mcNP76QW5nsHCDDHoh1SJfPdumzAH7a1s7xEJam+mr
 jMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714343115; x=1714947915;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ya0jZ8n9WJjJorfzw4j1dNGZnshBnu+wocUnYXirx1o=;
 b=KwibYTYy4ZZWJEZWSeXbxscog0PImSwhq3gPGl5epdNCsVdSmXEBQAAVrPAwyevXJN
 81Og1Cha3cAqpNhnPkzNHMA8MyP8B2rreS31pjIkJEyEXhEDp8fx4SABqRTaBEZuzoKk
 G2zYn+lJ8IqtpSx36xJloTQ5o6HPV0Wjz9gAz8NAwDkQnP0nlEzzFUMbGG5RbRkhRXu5
 MWSwJ5erL7VhNhxamUQCWB83fGq3CHyKG7XbiOrXzOZp7iNWmHilDXlZ7pXAD5bmMPk1
 nggKchlvMtLC9owHbXREFud/zMsO2KuJ9MAbcGDkWMAhFtO/tx7VjYHTpXLbi6ZwO90J
 uXkg==
X-Gm-Message-State: AOJu0YzW2RwyiyjVNacDceUSvOQUS/pQc/hxXRGpdDMY16W5o7LC5QCs
 KNzuQ0xNufH37YSVvIK5uROXAFVKrtpEuzHtr1T1Hsq4sMEiwDccGlUhoDe2sjt7BILoPDMzpDc
 N
X-Google-Smtp-Source: AGHT+IGBL1LER3mGihGCCvYWWcXvkFyk52j84L0TMsqGrHv9bOFZjswR1HgjGMhvhq3E8ZI9NoM6Og==
X-Received: by 2002:a17:906:2783:b0:a58:c277:345c with SMTP id
 j3-20020a170906278300b00a58c277345cmr5880818ejc.7.1714343115221; 
 Sun, 28 Apr 2024 15:25:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 cf8-20020a170906b2c800b00a58d14479adsm3158888ejb.59.2024.04.28.15.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 15:25:14 -0700 (PDT)
Message-ID: <b534d873-9be3-4a24-800f-603ed25c0803@linaro.org>
Date: Mon, 29 Apr 2024 00:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, afaerber@suse.de,
 ale@rev.ng, alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>,
 armbru@redhat.com, bbauman@redhat.com, bcain@quicinc.com,
 berrange@redhat.com, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, clg@kaod.org, cw@f00f.org,
 Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, eduardo@habkost.net,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jan.kiszka@web.de,
 jgg@nvidia.com, jidong.xiao@gmail.com, jim.shu@sifive.com,
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>,
 konrad.wilk@oracle.com, Luc Michel <luc@lmichel.fr>,
 mburton@qti.qualcomm.com, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 eblot@rivosinc.com, max.chou@sifive.com
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: QEMU Community Call Agenda Items (April 30th, 2024)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Hi,

The KVM/QEMU community call is at:

   https://meet.jit.si/kvmcallmeeting
   @
   30/4/2024 14:00 UTC

Are there any agenda items for the sync-up?


Alex maintains the invite on our Linaro project calendar here:

https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDAyMjBUMTQwMDAwWiBjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGc&tmsrc=c_k5p2lpgvbptdirku5si01blmnk%40group.calendar.google.com&scp=ALL

If you want to be added to the invite list let him know and you can get
spammed by your calendar app as well 😉

Regards,

Phil.

