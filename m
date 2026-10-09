Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8AFCA601A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF5UG-0005dV-KH; Fri, 09 Oct 2026 03:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF5UE-0005dE-22
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:57:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xF5UB-0002nH-1x
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:57:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso65318675e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791532665; x=1792137465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0EuEYkHFfY9ijLwlzlOggOpFY04jBqhn1BTQHm1Mx7w=;
 b=OxVv/u2lIcJ7RQwyiaG28WDmEwsOzaZ7wYhWVBAQwvbfA4asjqENkRyIxSGacUfalk
 D5V0VnJyOLZW1sRwsZ0PxP3OdsiyWAS5Pf467p2JhAeC+Osgn8oWF1wy5N40WKlMtdP/
 rX8V01fSLRlPkxY91ZVCJI5FVpW9wvSqNCa5oVXjC7Og614/09bsCJeQ9zfJZLF2WNh9
 qmFoP22k7UzQTlrhHPZR4GbAUFI5B7PQbh8airZn3WzgVUKH2BHkksfx8I9yaLVMJysB
 k3v3Rrk9P62Tbl7svBbvd5tYVR1eZMT2p77pMQtaT2psyoYmDqVYGIvAlCbDI27uahqI
 OQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791532665; x=1792137465;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0EuEYkHFfY9ijLwlzlOggOpFY04jBqhn1BTQHm1Mx7w=;
 b=MCm5x8Tf10sPh+w9GsckGwLt8HhZ8dYfQnBoFgueFKta2tgAMfxigbfn41xUUhBl5w
 WptAGR2AoTdM8oAwBjMSAlvAxqcry3ZjDpdlH+FX2X6VnAZGKBZOswYB1xg6Ldb/yXWu
 0mpYWdC79wesdvMel3wNUSrYQeRatN67wnSz1sB+XjcAQX/Z0ugEaOc93WJcpgD4rEPB
 U6JgHIvsTCfZhJgoaJOaengPKPdOEM8nD3CwC0udyIAdYSVyplO2N/ZBPqMYOSLdlsd6
 WMmNTz1fa7vHc2nsaH5fnuTYVMuWLOQ5337XASysdwyhn4F7Tm4Zh7LEN8QCvyA4nS9j
 Su0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8BhP7My1NuO/enyelHSQbGzbLZfStsFbJ6B1nAXrOfawe3ARVLt6Utdpx1aj3OYg2ld+UFvHXdcjb@nongnu.org
X-Gm-Message-State: AFuF++kFsZiCx06dDn2NwR8pOremQbUDGNVA+PlMWIsgzRdRI3IslaBR
 L959f5de6PvINlfBXsXvEPip8ad3oWyKvKDGrVcZGWsuWVRHb7WjiqPnVnLde/zilVnupppXEt9
 ozawfH/8=
X-Gm-Gg: AYBFou1A99dKHk026/K/akplR5rmlAVjp5wpFo2Zf7yvDdB/76oqcQFxVuH7uHb3U4e
 2es2Jqwu14g5Ym9Y+UWHYLkWc0wgdF3nbzWpaiRRsci5/yUbVYYo7Pw1d59BZUCNPidPmwZFodj
 nYe37/WAgAMiM2rOtTb/8drWzSbc7KVda5s16Rayn/diDpasvO1bOiia71+vpIVYS9qWX6otgyF
 QqORiiLlT8g6rL+fN7ySbQVwefhVLaOMzDJfCQ/UHPnEjcxDoa1g2G44JEv8s+PostUlyvkPMFm
 LUJhPT/4oh6TjtfLWkuZnxoU9q2SmR8K/wXVHWcvqV8ujjeNTxpJ01/6iHPNB37fXoEJcSlzNp2
 yfLOBkg+9W8TFg7BL49WgMatKwvHW4Y3UjItEH4jlAgifnr7nXTmDPeDAuXqWkT7yNzXve/SQBZ
 oi2s+KDPzb3g13ixuewSRLOrJiOQaLEuRWZVsZBnysgs3WNpWc8zh0ZfHxstEn87IX4i8y4K3vZ
 cC0io6dF99t3szjEGkb+tmeOTzw5+Ui/j3ieNqjeM/aDBs/9et9Rnk2L/4clnAjFrywhY+3ybAU
 QbkmVM2trL+G
X-Received: by 2002:a05:600c:4fd5:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a18e49a7e3mr18270965e9.21.1791532664895; 
 Fri, 09 Oct 2026 00:57:44 -0700 (PDT)
Received: from [10.86.151.227]
 (ipservice-092-208-245-012.092.208.pools.vodafone-ip.de. [92.208.245.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm45005935e9.10.2026.10.09.00.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 00:57:44 -0700 (PDT)
Message-ID: <41eca146-b4c4-468a-b92b-21912cbeb107@linaro.org>
Date: Fri, 9 Oct 2026 09:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20261006083451.956881-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261006083451.956881-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/6/26 10:34, Daniel P. Berrangé wrote:
> The following changes since commit d7a65d1793d691d356a56833620f7d1e6f5d653b:
> 
>    Merge tag 'hppa-a400-updates-pull-request' ofhttps://github.com/hdeller/qemu-hppa into staging (2026-10-03 14:17:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to f33fb19cab412ffbc19e3b7914a320ae1d73709c:
> 
>    seccomp: fix blocking of setns/execveat/unshare (2026-10-06 09:17:43 +0100)
> 
> ----------------------------------------------------------------
> Merge USB, I/O and seccomp fixes
> 
> * Fix seccomp to use errno action for setns/execveat/unshare
>    instead of killing the thread
> * Improve TLS performance and avoid test suite timeouts by
>    corking TLS writes to increase packet size
> * Fix websocket server unbounded read of client data
>    CVE-2026-101291
> * Avoid use-after-free in MTP device during object delete

Applied, thanks.

r~

