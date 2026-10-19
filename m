Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7866CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIhLb-0007nk-6M; Mon, 19 Oct 2026 02:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIhLM-0007aV-AA
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:59:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIhLJ-0006oS-JQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:59:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48dfb76b304so105407f8f.2
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792393171; x=1792997971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n5iM2FYHEZukSOMLLul7WBPirxPFEM7addOysQmjn8A=;
 b=RD9kObxI2mJwUUVe9RbKMkz0ZOu6V2vhrJ0m7dVsRh2cPTob2O0Ej1fzV5/wWdNoQ1
 lZ8zI0z+HuCSURK8d3Fh29M1+FCQEuhwvvOFIOnkUshMCYA7cS6kk8Zd+xCvAHJT+LQs
 S8J0zfQMMnp94f9GXvDTPauLbF/SsGmLrdEU/S9zZk60A5Ar09HAeVaw8wSwVYrwE1Uy
 5VHZoEdnzw3h3gLX7seauJbjLD8hIn8EVlcBPTjcTHE00SmfLnO3sz/IduL/cFlSrSUu
 GlcepaRcw1wpkGR8gpq+9TSxWWaFELAIHR6RJ/H3AMpw5sylsc+hXlLcgMeNTX7TnPfR
 fRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792393171; x=1792997971;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n5iM2FYHEZukSOMLLul7WBPirxPFEM7addOysQmjn8A=;
 b=aWIUVKKW9fdU5/KbhwovQzMIUvZblQRhgVXPUJpARW3QGAeRE+7ae1ap/Eafen/X7I
 r0jjNwfh1eXT0zDQz0O/iG1h5G43hD65sERxSDkokhvIW7cUa224bSk2xPmzktiJPJC0
 H/7LZKuKeDtyDDMtoUUCrrQKnIxn0ytYQxaPR/79VqpK7O7n0XfHFtgW1d0vjDhBOQ78
 hefVjf9Ups3PueGd3QsBthArts/pL91fOHx/UxoK//glRTQtbN3dP6O7G7w7E1su5S6r
 7DPlvhTEdEzLCQu6lMu6hzGmtsVmOgjhlHtctwvoqodMSc3VellXnFBpnHbyWN5I7oKY
 Mriw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQXclg4yr8FBCk9FyU8zFJfr+Ow3VWh12Iz/uM+Vk7wyffAUBgD/s0xlzl91Q7dH1C7vbq+nhSLCEw@nongnu.org
X-Gm-Message-State: AFq9FYLqWG5iKtNFn7dLsY2S+i1Ou+NSStCCf1LuZu4TVBQ6QWORyB8w
 N7ylLHcJbZH7zIXgx6cq7KhyFBtYeItTlYM77Y0NwUKjrcoaeGpuqfz1zl6hv/Fx+J8W5E7t8HI
 inf01Jbw=
X-Gm-Gg: AYBFou2G25o+qxtqbGEUZkNKUkQr4oWV+tBDd+UsTtVW4KR8XZIH1qSnEEEabp9W1e0
 42m50H48MIIlqlllJ2A2OJlEHr80+ANhvzKK023vjNMqKCB1CSn5HmSN9Xz3oAwCy6ZTvyCswE3
 L0pKtPyRlqULlmkTfBw9+3jEwBBKN6AOF3yBlzMNh3NT6f/SbAO6D1E0QN00l1BYld1gjCQyjA+
 NE9J8mcEBAibhJcUpMNr8ksAvTbLohU0txF1FgihMI1JbB4IpWr74czzktM0modRvglbu7xubxy
 pfOMWlv2oNAtP4kPMKbMETDOH8b4PITuzVIGnZxNxQTjuhfp4LzlIep9UJyFrFN8D8BySot2eMZ
 Eh+wB1BgJT8fY251EDZOUe5hEDlaovxchJWcR9bVZT5RqLJDAC7ZmjGtCFzlAHquhjaz4SAxAii
 4DpsmFVMrVWlmr2Tns9DjSjZqJiwfTR13k4zGYjTvx0AwHkTyshMDdIJpilutd9ExDNlCRjWyIx
 VcaNeUgTz9fqgBPxA5tX3YfLpXnkBnlYFUqT+cPWq65OxtUciTQWoBcJjzvh6rRCBTmJGDq
X-Received: by 2002:a05:6000:60b:b0:487:1662:cf4c with SMTP id
 ffacd0b85a97d-48e0797ffddmr13621722f8f.7.1792393171102; 
 Sun, 18 Oct 2026 23:59:31 -0700 (PDT)
Received: from [10.89.180.227] (cust-east-par-46-193-64-64.cust.wifirst.net.
 [46.193.64.64]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c0894sm19199397f8f.12.2026.10.18.23.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2026 23:59:30 -0700 (PDT)
Message-ID: <75480909-510c-419d-b378-2b6f1b55700d@linaro.org>
Date: Mon, 19 Oct 2026 08:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20261016094348.2616374-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261016094348.2616374-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/16/26 11:43, Daniel P. Berrangé wrote:
> The following changes since commit d5b5083cb783c447001e862c2b525e59f48ad78c:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-15 11:53:41 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to 87e403247d318a6b782d3ffe20e1442197d032fe:
> 
>    Revert "crypto: implement workaround for GNUTLS thread safety problems" (2026-10-15 16:52:01 +0100)
> 
> ----------------------------------------------------------------
> * Really fix blocking of setns/execveat/unshare in seccomp
> * Fail fast in qtest when QEMU terminates before a connection
>    is established
> * Deprecate use of instance properties in QOM to encourage greater
>    use of class properties in new code
> * Drop obsolete, disabled & broken migration workaround for gnutls
>    thread safety bug

Applied, thanks.

r~

