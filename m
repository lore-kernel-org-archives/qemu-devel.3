Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D8BC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPc2-0006fQ-F4; Wed, 12 Mar 2025 13:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPbu-0006Z0-U0
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:11:16 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tsPbs-0001Js-IU
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 13:11:14 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4768f90bf36so172801cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741799470; x=1742404270; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7vYdEeTKvVY7Tn8T4keB1q6tEDTbQj3MxR+j0vI7wBA=;
 b=YYaVmoHDat1JgzKXtnEezsW9Rp/ALnEFHuZeyPRjjq1oljHaRbaY3N9cf9K6+aVHRi
 5PVw9ILohIGng0e/hSMNkPN6KW8R5vSusShd502o5zDbLyepohoFeMMKlK8Sl6vkrqs5
 bGy+LgfbkquqOCAzcS30AVuFxxYijtP8gjvdpJZRIXOHIR3eHP8HaFk+moJ9dcdA2gIm
 cT8XfEHuFKFqrV4DtbOUFY1f0P7fmZZ9lTaBJzqQb1ExWPYMRweN66aHpvVo8V/xTBsG
 cYxdiJ2eNHKK12M5NyeUGT4mqhEYDLUCWcHa5QnMbmXCrPJfX2NHXgE/S8r/6wVIXkVQ
 wxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741799470; x=1742404270;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7vYdEeTKvVY7Tn8T4keB1q6tEDTbQj3MxR+j0vI7wBA=;
 b=S5Ud5URd61YlBqhGQNgd4i7cFaFTlVoc/j6BPJNWyReejjoEGvGyx7iv8pGVeLz5lU
 fkASu36ACpy6iRyoDc4XIiG4WKdW97IOWbruqA0ugrL+DLf4GMRA7DLwQSxW1Sw48KvG
 L0fdKG5aPAOXM/SSAEEXe+gvpXGBK4k+ZWMpZem7gGb0ROlYHO0awRSg1oEmSdl32LHp
 lOxMBi30lfmpIfHHWukVRS7nK7XF/fKiMXVrJzBYIHUQjVwtsXw/s2eZz2oBjpZnoJZV
 n8Ifvopq9p8fccqB4vBLR2dkoUPHQ+mhndKUSPUw9Qg9RmWsEK7aey7bqURvJsxrwQmK
 wWyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBkmWfkOlgMQGMElG6X7sOmrNAp4J96TljJsM4HnZGp4p7az//e/vaV/pH0x2pzvx2tPmLyy11bpbX@nongnu.org
X-Gm-Message-State: AOJu0YyGszOZH/dkEZPV9As62fx4ZRNY52EyXbkE0dx1znwD+Ndey3Rf
 LZcCOhKUk9JTLzlofg4hFi7mgo5HK2D6Scc+f6mz12mTh9NbkpJe
X-Gm-Gg: ASbGncvGZ4a6AlzdvX/iFh4eOk6pYqVswu8ByULVfj2k28N40FCTU3E3QWX6KzHYD5E
 tRDWloqz2mwJUlDaLHB8ujnobk157N6Hk4a//Y01B44i8c+ixAuC3kTR9kMXfolajAOTJW0ryja
 MRbg6sZL3cGIPCFk4pgBhvalm00mcm/rBPXjJ1kZzMIiMQpJd+jX03+FGWSR2R7ucnoBXTO4dHB
 74NMPNspxkOcXRoGbBHg7es6ZlYpvBlHtf2CkKK+vQ0GUaWiryIxAfls6NWtJ5PcovjF1WbNnVb
 blRcXJsZoDdfyH/QNebXJQuZbfGU/+u7/6Lob+FP0GSvZfBhjNaOET5FFbNhVUk=
X-Google-Smtp-Source: AGHT+IFe6zwVnd2+5bSUE/PzXSU66aT2mOSXbWTvdS36boWuQSeKKhMqsVEbBJ7Kqh8x27/tnyYTXg==
X-Received: by 2002:a05:622a:540e:b0:476:639e:edf1 with SMTP id
 d75a77b69052e-476639ef315mr253079691cf.23.1741799470382; 
 Wed, 12 Mar 2025 10:11:10 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:9cc3:cdb3:7013:e1db])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4768cf1ec2dsm42113551cf.31.2025.03.12.10.11.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Mar 2025 10:11:09 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-38-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-38-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 37/38] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Wed, 12 Mar 2025 12:11:08 -0500
Message-ID: <011401db9371$c006a4d0$4013ee70$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJoWDJHtPDgnNA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250312-2, 3/12/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 37/38] target/hexagon: Define f{S,G}ET_FIELD macros
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



