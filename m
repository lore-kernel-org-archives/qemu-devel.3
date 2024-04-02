Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12181CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbjp-0005Ro-7B; Tue, 02 Apr 2024 06:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbjR-0005KA-G1
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:51:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbjJ-0001Y9-NK
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:51:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4161eb1aeaaso183125e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712055056; x=1712659856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ag8lQSrpfnmNFe7/fsUvQUM5//loG925OW+hb/sf4pg=;
 b=UI/1YKQi8nqMZY9aArNDbz2PwhhgXEdl4aNomviUz4otsqAws54SoFAXQoJZUJBxnq
 TfkaHKQjGV5UZecG3oajkymqjlIHzaQ04e0L8jva3Tg2zeqkvBjDVTedf5KMgLFHYBYd
 PJjr0QYhBCEzWfQCLihIDw7czLdPnP0smjZyDs2Jd3aYbtV1QK9iFWR9MP0qvz+n+Ubd
 hS86t4FUi4tIjlU8VpP2pGuVpS1iIt9DBzTD8aNjkMJmMaCkiSx81ZCkc1xWLVxWIU5J
 vZjiXU/S/wB6iybO73GPyP2VEA9HDmnMq00QmNZcJN7SoNUoq5ftO0fgNsC1ISvYHks7
 Z52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712055056; x=1712659856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ag8lQSrpfnmNFe7/fsUvQUM5//loG925OW+hb/sf4pg=;
 b=QyucGIrTbBnSqLVPw33e1hyTqhbZu1+xX5HaBqSkD5FFzZaleXiXF+YYEGbF+dtkrr
 qEQIQ8J5zDebUyHiAocFaGowk7FjWYQnsBMER3ep5oh7jdBH7xXm83D7in2RB45QCB+f
 JbGcV7PAMuLISw8IN2vK7hDAOnxqidMWvxa9ZOueMGEBlY8XuEAXuIpnafAxyF5yXs0W
 bsQx3152kKNF06Y4Fg5mEJRkeXQ0epgTeoT31IdiaZAowVm9RetkThycBUPqEdxMgicM
 xZiPSVUW8LtF5A9wLc3h13lL5QGLAsrYw/wqu93QMm8UZQdpmPLj6jW/dWs+Ayfpn+Jv
 GpsQ==
X-Gm-Message-State: AOJu0YwUjbecPI11vK7BJlVCKzEHN5GcPaWWyzx4pTMBMSOuQcb2yIjF
 fgg2rqVXUvpPExAHmry5PEV4n6TqbEL9RNF+SfdISIBrGhbQH+JfDfjDap198w0=
X-Google-Smtp-Source: AGHT+IGhz0ywr/Quw/0IYe13GpgLhURMYgBJrOsRlPCnzQp2nIY5bt12UNLCYRDe8TvpjmIwWci5gg==
X-Received: by 2002:a05:600c:1f8e:b0:414:7597:c2dc with SMTP id
 je14-20020a05600c1f8e00b004147597c2dcmr8937990wmb.17.1712055056485; 
 Tue, 02 Apr 2024 03:50:56 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a05600c4f0d00b004161af729f4sm1673724wmq.31.2024.04.02.03.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 03:50:55 -0700 (PDT)
Message-ID: <01cc169b-9e3e-4f42-ae9d-380007660e02@linaro.org>
Date: Tue, 2 Apr 2024 12:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Fix error-report.c entry
To: Zhao Liu <zhao1.liu@linux.intel.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240327115539.3860270-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240327115539.3860270-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/3/24 12:55, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The commit 15002f60f792 ("util: rename qemu-error.c to match its header
> name") renamed util/qemu-error.c to util/error-report.c but missed to
> change the corresponding entry.
> 
> To avoid get_maintainer.pl failing, update the error-report.c entry.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued, thanks!

