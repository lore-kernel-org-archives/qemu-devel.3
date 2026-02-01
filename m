Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB35D172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmg8F-0001da-An; Sun, 01 Feb 2026 17:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmg8B-0001cV-T4
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:41:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmg89-0001ub-I9
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 17:41:23 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-481188b7760so24175375e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 14:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769985679; x=1770590479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wn0xVINq7GbCMPNx98a3jkKQBlyDwtzopgh7+QulA6Y=;
 b=Z/mVCHjK0s1ncCi7PKprdrsNrwTxZq49HMgfg1XYN2xLo6G7aUPoNSWlZrPcpIAqPJ
 IT6uuyw3UZM4CAWp/lFOgkdMhZmJibqdw9wUG/kdFVRXthkeECP6F3la6NhiN4izWqA/
 3boIwikPCQ81vg/bzTp9oKcwLGJ3d30Jfb8nuMhqqPYya0LOi6zEAB1voGf36VUh4KwK
 HTiXv/5T8YIW262rY0r8owUnhFolh5zLc0kFo8N7bmghjONbQGqI4MDk3+sho4HDGf8A
 VizPRIvkjHNPD72hyCiu0cEsHpR86ugBERw06rQ8owlonKIE3dCcsu8UsRTPY8zQ8EOR
 ejpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769985679; x=1770590479;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wn0xVINq7GbCMPNx98a3jkKQBlyDwtzopgh7+QulA6Y=;
 b=YZt7Pu10cdHyXCMwCeQOF4+/LzGcqA3e1VGsFZSbw0nF+Y8ZiPu0yQlm5kvClYjmk0
 8fX3l0Hawu4d0MFd4ufoh7XDAv22d+2XhQnIUjaB4spDC/rPum6xlCqaccc875HG8vZm
 JC6fhSG3m5LJ5/OGu9J+zbSwyXUPvQ8brGjsCrTtsQhIBlQfl7kRTEBmwlSB+o5yr+rM
 1788iGJxiBWVbhx0ZR3xWF6WNgH2qHClISEzMiMW/YUv4mzwBDo9/8tGe2wUTh0GoHGM
 jlcI+jRLb1JdBWPu7nNsRXBo7U63bwVarMmcLI9ggY8J5pTvdZ8GnZ+pD2kFTRRyBnmy
 9TNg==
X-Gm-Message-State: AOJu0YyhFYiWXtuCVTpfTkxUFDXX+cBFdnqDy6FseTtIUIAwDw7KnAqy
 8d7gOP2epom/x/kb5j/iUZglUJBXOiij96alFV2PG/zQthFNiT2ddg4FB2BTJwGn0Fc=
X-Gm-Gg: AZuq6aKLxXxaa0H+Q3PpkwznWLZhi3LxRjf74nIPLMkqKiiFCDAVX1ARnYhidXy0aB6
 CTKyjrAEl0UFPfrwa+xmZmdsfAOUeepe2YWlb0zOe8e2Hm8tUUaDb8v3fzNL8Wd1pxqtid7hWap
 REziRi4gXtvtwIoMbKAljRsMhulg3tTiRpHMjhHLaGM6rTObpOf1ZnxGi25yEIxNSm3bbZPPop3
 eVLriIZWqJsp14nHfFgz59y00UiwosHSLNWdBmiPMXiZ2soOSwreBJxaTB8ODgAA3FfQ6S4YWCs
 ICw6JjW2JwyU/lCM2y8UY4YoQlJfg6l9sq6cRPZKGMdgZAp5wzKywLNIdBqyTawMutld7FHj9fX
 QU4quiznwpx7iQDQh0p5/4omL12t0gkkljGNNp+27eStMyUvoP697Pn914TCch+lXkVOS59mKT4
 K/tgTp+k8lEO1/ZJ9cU1DCJ9L1JXzP7kQROtZQN0C6cEEenFe+jtv09Q==
X-Received: by 2002:a05:600c:628d:b0:480:1c75:407c with SMTP id
 5b1f17b1804b1-482db4577f3mr114508955e9.2.1769985679055; 
 Sun, 01 Feb 2026 14:41:19 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cddffe9sm504986385e9.4.2026.02.01.14.41.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 14:41:18 -0800 (PST)
Message-ID: <3417f499-f5ac-41c5-8d40-33c5c1c10e50@linaro.org>
Date: Sun, 1 Feb 2026 23:41:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
 <299f59f7-62c3-42f4-99c4-b7c7cfb111c2@linaro.org>
In-Reply-To: <299f59f7-62c3-42f4-99c4-b7c7cfb111c2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 1/2/26 23:36, Philippe Mathieu-Daudé wrote:
> On 31/1/26 18:48, Michael S. Tsirkin wrote:
>> On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Performance impact?
>>
>> the reason we have these is for performance ...
> 
> If this is a worry, we can declare the virtio LD/ST helpers in
> VirtIODevice and set them in virtio_reset(); the call chain will
> be even simpler than doing that check on every calls.

Or just have a VirtIODevice::access_is_big_endian boolean
field (re)initialized in virtio_reset(), and drop this
virtio_access_is_big_endian() method.


