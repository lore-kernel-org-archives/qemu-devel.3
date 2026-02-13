Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8F6EF99E0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 21:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr16k-0008I4-Pm; Fri, 13 Feb 2026 16:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vr16j-0008HO-8n
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 16:53:49 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vr16h-0000Mm-QV
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 16:53:49 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so1469084f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 13:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771019626; x=1771624426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vmJi/JuvAklFCjQHtQcZC95MV3mRFS6Hn4IqCnOoJmo=;
 b=L64Ga6VSbgVh/mnm8LcpPHChNblIRKe4sK6biLaYl5IX2rLvuPYOhOn5bjIIDHbIYq
 2eDmOq7fMYxxUn5ybfdcXVRXwCu2UaE2uvLKFJ7mQCtp521q5gpGv3MP7+u4P58L+Zdm
 kX+giJY7TJxJCgsWcGLzKqP09ccxmHZqcLcrWOfxShCLZvLnhoiVplvwlJpgZzWPO3ue
 xgKepjn8pKGuJl/hAMSzaK/pPFj6UxMF+uzHcTXkCV9ZePcY5DFkn71FPfOCENQf9eot
 vF4qjv0cDwijW06WpsCWCQLv9cJSoVi94Z5370Lpxd9n8aSZRBZNtMwf1qsXz+Z4N6WB
 p5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771019626; x=1771624426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vmJi/JuvAklFCjQHtQcZC95MV3mRFS6Hn4IqCnOoJmo=;
 b=KUJO3OJO6pxQA5Rq8K6utvEML2iKOYe9kluHmRlQGDtpPOh6Gnhzb3ug/lNWO88Fq3
 m0ScAFwpZQhgG9TRKQ3nSDCyPTQP+zFCjJCr9wtLlpVLOmRRUB0oMQf3GRomVaTF2QeA
 NjIuA7y9agJsruDhdS7Da03QlG/7YTywEcHg+/K1F11r8vozWLKsc82VK3BdFUuRUl8/
 Mkzg6YF5mgiSxYsFfH4zxDwOZpYpnWx9SA8zbDSlwmE+MkMTgtT7HDF1pd1YmKbqBXho
 zqIA62z2RixWJqc+dPFvqBzuux6Nj18ENPEyyQARGJiuyz5q/BnepuDFa3QxcM6Ce8DT
 cZhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnsqv0GfG5y+9hcVU93mkA4qH9/sKLRL3r+jWX86n2iX5zJzPam9nkT6o0nt0SDcprnWw6mBPDL2yp@nongnu.org
X-Gm-Message-State: AOJu0YxIr2hnoykx5ztdIQzar7wcnU9OxPlxdIjCI8KDbaU7s55YuPlA
 U8nM7oZxxvT8K3bAoffguWov7mdxgQJrF6xwjBQp3X/+cBR+ddQQzDVY
X-Gm-Gg: AZuq6aIcUWVzX6cE6w3nAv+4+vFYuujb6d/vMNQX+nmoyQbcXXTUtTIJSXn3ZaJCzjq
 4XOIJydAgAKPXmD/rAm2XtnNFgoBDeocJM7NQw7Pr5l7fg0MK5kTAC2VHcIlOnt6IaNqrKrPrsX
 U0N9g5Ud1k/ViLvSnAC7PjPmaT8OBZec8vKnZMOMRxrzR6ICkbdXQUppv6cssRkY8yrqmn0Jek0
 /cv4BwVnv6hG2ivr2AneW/xyNclSbgpx3x6nNXUNLpr2+xJyK76KSjU7s0BohRoQuxCFLSge3hg
 9zs0uMjkWYjqGqNAlwRBgq+RC1L/bpLLxLgvvdim3oiiFluz/gdS0ihD9axhOkp705vwB0hTF7J
 9djX/dJKffPBFMEDzT24qPlKmRru4vR766/h48Ybd2ic3+BaX8nl5M0yr6zPwHrr4BLdVX/7fZr
 S1olobGzzjKA8Gml31L/K6/5+j+tEdiDP1OlWk8AwAFXTP
X-Received: by 2002:a05:6000:1844:b0:434:32cc:6c86 with SMTP id
 ffacd0b85a97d-4379db61567mr1647492f8f.14.1771019625452; 
 Fri, 13 Feb 2026 13:53:45 -0800 (PST)
Received: from [192.168.88.253] ([82.215.83.93])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abd259sm8412691f8f.24.2026.02.13.13.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 13:53:45 -0800 (PST)
Message-ID: <45a6e2d7-8909-401b-9c99-3ad3da4fd982@gmail.com>
Date: Sat, 14 Feb 2026 02:53:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <5961971.DvuYhMxLoT@weasel> <5e904364-240a-4853-ad28-b2e3c5ac8f83@gmail.com>
 <12835278.O9o76ZdvQC@weasel>
Content-Language: en-US
From: Andrey Erokhin <language.lawyer@gmail.com>
In-Reply-To: <12835278.O9o76ZdvQC@weasel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=language.lawyer@gmail.com; helo=mail-wr1-x42d.google.com
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

On 11/02/2026 19:07, Christian Schoenebeck wrote:
> On Tuesday, 10 February 2026 10:45:09 CET Andrey Erokhin wrote:
>> (BTW, is it OK that there is no fmode/dmode processing in system/vl.c?)
> 
> You mean error handling of these options. Well, earlier error handling on one hand might be more desirable, but OTOH it might also be more complicated to be handled in vl.c than either in 9p.c or 9p-local.c I guess.
I mean dmode/fmode do not reach 9p-local.c, at least when used in `-virtfs local,...`

