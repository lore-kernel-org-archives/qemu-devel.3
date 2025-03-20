Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E519C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvM6E-0001JX-Jv; Thu, 20 Mar 2025 16:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvM64-0001Ip-FY
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:02:33 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tvM62-0006E5-Ua
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:02:32 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6e8f43c1fa0so13660636d6.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742500949; x=1743105749; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s1+NUGKvYJ7Far4LwZ+UPAw8pnxR2DWAkwp7txcfKl4=;
 b=M5iZjsAPpbEerGGdCns7HBZpslLyDVkV8xyN7KH5fVeY40/62cJJrIm6Yaee305wlV
 jcG/OOXq1jdPV7ezZO6TaBHoEKiVrmeckNNJZ0GmV4CYavIXj3nZvFpVpGfstBcJOvxb
 kbLw5FmDFEWFzsTA7YAUbhdNQKSXqAFc8NqAs/gb81Fpw+jcQaTaaeV0vmnHBIgCWD8u
 ElfU6Rq+Y1szR4gyhjePO9Eyv6xE66NOaFEB0bo1C+SUcQzusR3kFEtsNVf+TyWVbIZt
 WnbLmeq/qrxPb0XiXE00k+G5C0QWguF7/jZXovOUNTDVR+Av3XPeej0KvTLVf29QkaCE
 BH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742500949; x=1743105749;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1+NUGKvYJ7Far4LwZ+UPAw8pnxR2DWAkwp7txcfKl4=;
 b=haNGEkN5Bjt9jSVuVVK1UuOaiDz4uqI/EyD9ZRDtLfEVGUYJdPFyA0ZFvE03tmh5y/
 6XHTBLNdbRi0mD7oALYHB9LQoRoa/1hpZw8EyGEOQOk35DsxveEhdpuW9akfPTb8n0X1
 iDndXiy1PX7i2P0PPotyQD0svLIFNqkGB5JcDVOBNN3XD7Q36s4pciJNx0vqunAMOQFB
 PvCFOhg61mFeeN1nn9O+5Q/rbNnYjkCwUzpTFXMfOwqGcoMZwq+GzGM7AMabqDXWq51w
 NYdJ+4jG1qpEqQD2vgp3L4glKSluXSnZ8970ZWtxGtRAR5ClK9ooEiafuIsYrP4Xdv5v
 JtLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMFfgSjKbOgp4Fu+WQisoE8IeYfTDJTvzy+aFNSlNNNGgEvHHCzvXge6nxppT2jBMNpSuzansf16Za@nongnu.org
X-Gm-Message-State: AOJu0YwT9PdiEHA/6IDF8+U/NrMVOg37UDicCFnhs/walK0Lo41XDv2A
 gHmp0d7U0Ts9nt5hRPE0MPPx2R0JSvNa6aGONnpATE/IG99J9us/
X-Gm-Gg: ASbGnctZ3c4Mt07Z4S02xnfXwKz32569+MvExZ35cbbV5B+JJsVU5TUS3NIkcEencm3
 +/nJp6Ae/lwYyTOJcyTvnExMFvy37LMGbaZ5yL7/vIrRTigrfvB0VdnIBOSyOjzBZDGlo6M5meI
 USfi/XTx5qoGce/flUdLKVqM66NgzoA0MhtEJ7P4oSPZvlEcKoDs2sKluW+ELj9wjLPKv7yK9Mi
 EO3I+jVyVFCOwb6EBIf7eRXH1uJiAoTxL6Le/VrNgDg+FCcF4bNFATpa5Sm2EdY71H01UTEdOL5
 FfgZJxOTzAEWhw7OUvvryBqs67XHl65LM2wfuFcP5UULMjmEh3QZwQmbY3TOMKE=
X-Google-Smtp-Source: AGHT+IGJcEotVxQJUNnRI2CWzpsq6Jw2yW7mj393uWm7mrn0QKZSVH509Ckjq3V2JsXZR74cx33fkg==
X-Received: by 2002:a05:6214:194b:b0:6e8:f133:3795 with SMTP id
 6a1803df08f44-6eb3f34b5b6mr10327336d6.32.1742500948681; 
 Thu, 20 Mar 2025 13:02:28 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:7462:60e4:5895:7c5f])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eb3ef31810sm2135196d6.64.2025.03.20.13.02.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Mar 2025 13:02:28 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-24-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-24-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 23/39] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Thu, 20 Mar 2025 15:02:26 -0500
Message-ID: <03a201db99d3$019da760$04d8f620$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQDWfh6NswBHUlA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250320-10, 3/20/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qv1-xf35.google.com
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
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 23/39] target/hexagon: Add sysemu_ops,
> cpu_get_phys_page_debug()
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



