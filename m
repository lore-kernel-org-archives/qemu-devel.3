Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B546C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 21:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtwH6-0001AQ-SJ; Mon, 08 Apr 2024 17:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rtwH4-00019y-Re
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 17:11:30 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rtwH2-0003Ez-4y
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 17:11:30 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c5fdd1598fso59794b6e.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 14:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1712610686; x=1713215486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZhjXq5jpToYvi31HTeoxwrwjvaM8mJ2+OITPww609M0=;
 b=WuJr7JVGAP+vv72+BKyl8viGypmxRPfifPk/sDLdJfpx4W97fhF+bx+6vt1HR4j4qb
 HXKIKw5M3l4rfGMycGfVnugwCb2rLZ+NYdkhV3m0cx4ng2V+sHaSxTPgjC/9U+5yAdG9
 JNFExkknFlM1j1fiGC75myg2UUTHeHbhbDByw7JoRWwABbLQplBdI3/aSuE/Xi5SsCVd
 VO2/UuiWu8S6lR2CMjGYTxfu2Yjbf+vAxKKcMyEjjjXWfNNVY4XowBEbaXIpg17mZKPn
 n7em+SeCxOs+vlcYcwPVdHBPCWvqAjW2aXHYm68tWpGNl4yZRTWFjtyDOZgyZMCAnIKh
 qJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712610686; x=1713215486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhjXq5jpToYvi31HTeoxwrwjvaM8mJ2+OITPww609M0=;
 b=m6FtifJ4JqNYRkzMpyth/KgdTnLqqnbLq9Ur7S3e9xGUJxwtnf0jjVBE6+j99PL+yr
 ra2xsUL/1ffqOVX5GZJd7GA7orRlFt56QBJbPcm6UX1zgAjAFgNkHegHgrRkFVCHQgdv
 SUR1seKwssFHrvVJr8HxbwfTAj7wEpauM7WwiQT6u7bXJ3mrFqqoj1Mcr40uv54enTJs
 g+3R3DrZAHcoTzV6M0iRW7LbjcUV5cAmgo5vIZvHCfezKg/+TlirJTaQkylU6YkO+aZ5
 zeGW8mBJB7gjovFGkL6MzdfL3F0/yhlkpPUF4EBfXw7Q52cHo6y/pQ7AI0HLStGdLpbZ
 xOXQ==
X-Gm-Message-State: AOJu0Ywy3IErP+kgaGqBtW9a6OPdDJf3WvXNfGEh293aUfLNfZkuqu+Z
 StBEmvvXTOy9fhzIj2JRT0Y+uqbrDkQaVxSF1lplfutzcWCsYOkQ4jFqiXi7XA==
X-Google-Smtp-Source: AGHT+IHO5c/JpSh36wdse/aQVytytQxyPxJo1Zy7BbvMQtMVWspZbNdYE6aFdu1tzoiiCs1W/6gXUw==
X-Received: by 2002:a05:6808:1155:b0:3c5:fbcd:a276 with SMTP id
 u21-20020a056808115500b003c5fbcda276mr1917782oiu.47.1712610685829; 
 Mon, 08 Apr 2024 14:11:25 -0700 (PDT)
Received: from ?IPV6:2600:380:5434:6799:9dde:19e1:4bc0:4b46?
 ([2600:380:5434:6799:9dde:19e1:4bc0:4b46])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a056808004300b003c5fa8c0e8dsm179390oic.37.2024.04.08.14.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 14:11:25 -0700 (PDT)
Message-ID: <95a5deb0-2a01-4a74-829f-a24de0c6be0e@cs.unc.edu>
Date: Mon, 8 Apr 2024 17:11:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] e1000: Convert debug macros into tracepoints.
To: Austin Clements <aclements@csail.mit.edu>
Cc: qemu-devel@nongnu.org, jasonwang@redhat.com,
 richard.henderson@linaro.org, Geoffrey Thomas <geofft@ldpreload.com>
References: <7e66f00d-cc69-458d-be56-266689757f68@linaro.org>
 <20240403134546.1361812-1-porter@cs.unc.edu>
 <CAH-f9WtDa=mZgbBPHwOeswMqbShabCjKqH8SXvXOTzhgCCc43g@mail.gmail.com>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <CAH-f9WtDa=mZgbBPHwOeswMqbShabCjKqH8SXvXOTzhgCCc43g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=porter@cs.unc.edu; helo=mail-oi1-x235.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/3/24 2:44 PM, Austin Clements wrote:
> At this point there's not much of my original code left. :D Don, 
> you're welcome to take the credit in the commit.

Thanks Austin.  I'll send v3 with this change :)

BTW, my attempt to include the appropriate maintainer from 
scripts/get_maintainer.pl (jasonwang@redhat.com) bounced.  Any pointers 
on who else should be cc-ed are appreciated.

-dp


