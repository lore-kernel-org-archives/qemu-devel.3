Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808DECCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpdP-0007nX-Qa; Fri, 31 Oct 2025 09:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpdN-0007lg-Gl
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:57:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpdF-0002rA-ME
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:57:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so17050565e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761919049; x=1762523849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Uu2pXvvys/JhmvtWy82nPnqJ8nDsDCiyEtAP+6H/hQ=;
 b=OltsDaPM2q1Hhs1NZ00AGtOdyYNg2iC3U3aRHN53GpgmDZJCTeaIsnSQpMA3ewD23y
 PexYCVl6aJBSVu4qJML/WVohXNu4mXV5iYSuj8XY9HD2kbaRE8z8f4GT4jRdFh7N3fPl
 6wwkY4Qqz+eKHZXZBey5etm4ZYuru4afAi+D2l7n2u4LQKUpYDbD4CbDxUd34kCFcmJe
 cQ39Y00iTYdUNnmr/pg9coZ5Mc1nYpZPzo9YzuGHWljdrXjHBL3JTfeBDiVSb/SB5qgF
 v5tIh/Fr1DdNbBgZgwxk28JNzzmdoZbvL+JlbPs3U5Y1voTOWzb/E9dXdiY0w8PWo/xF
 ER3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919049; x=1762523849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Uu2pXvvys/JhmvtWy82nPnqJ8nDsDCiyEtAP+6H/hQ=;
 b=WjY9K1o/MzGeltKd73Jl3j2Nj/kmpdObLveP1gT1sXOK40MVRou17bA3HXh7oY9HTq
 R5mFytBKY2xYOTB1EhDA7ih5wk31+YQ+/fx5HvonTeAxwkfNw3l6CyrAev4j0nG8YPeH
 gHV2mvrxbC3XC1go0Tb0FgXCb2TK/fR5mzn5Ogh9xxACJfUkqlh6lH+Q1XFLWxxVsuEf
 gcnea7yzRY2S+vg0FeLPV5E0EYmZlT0VmSAD5VdAii/reeTDys0Zf2lz/RVLaIU6evdr
 FNXU3Xv3+3iNjG+aGYuGu6gMO9lDaeKE0KgtxT/5fJs9198nNzrkTffljYgx22yMvkxq
 yl6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2bCLqhckMW3Srnq+q7mGvf15cWHyut/sD1CL+xNiObBuvr9ocuycgz9epqgezAtovhi+sd92QbOkz@nongnu.org
X-Gm-Message-State: AOJu0Yzwi/oWN3ty+VpCapZqwnYWcrqTc4F1rjTG6PCeN3Ym2IXNmqA4
 jkH6jAdzQuRG72DmPfEemtfPez3NG5nbDZK2nfhS1FxmX2oi3MhijJ1FmXWQ68HctM8=
X-Gm-Gg: ASbGncuLFtQYSltAxECP5leY8mGLXXYvJv1tcfw0wAl64mn5sYsVNfZv7m3HYTpgrEZ
 Za7adzvtqyJeHrB/ZGa3Ravw1bf16evtDiXRvOTGbRFLC3cbY1BS4Ob8AkaBB5SDZ0TlnLXvDfY
 QDkYBpgzJC5xcZpuVeXwGTzjCe1JEK6+ZTAEhvL2siB69TdXMwT8xdWEbhqw4O8oIK2CEf9F8sZ
 +ceXZABUldT6PLTqKO06Zms25b5J36dt9Gaxog4sFVg7L+F1s5Bu8dieaJMNy0ZTgVVA2t8yjwY
 Aws8AKsU7oOJ3oEqaDF8RUUQayVK5q7AykD4dWPw80qXlgLl09J1U8KOirDTgjuhEyq65lszrK2
 frbLPU03CI6T3n0m+/tmq1ojZ3hPkWv4kOR5rOkYkN42W2MqXWqov5AB0ZZZxzlxoI9VZnitNS5
 TcjwzZyM9zOKY06G+95ly5xonQC5msXzKhiAmk4fa4y80gsEIEvFQlYIvessH0vuHT5nVE2vNM9
 RF2
X-Google-Smtp-Source: AGHT+IFnCNhoiLfM/dNFG0wia2jUWxxG+K32Ohq0qWofAHBISz5tEz9aEZ7DLmXEirNw2nS2/UWrzw==
X-Received: by 2002:a05:600c:6303:b0:46e:4be1:a423 with SMTP id
 5b1f17b1804b1-477307b7e7amr29349165e9.1.1761919048695; 
 Fri, 31 Oct 2025 06:57:28 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47733023256sm36099465e9.17.2025.10.31.06.57.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 06:57:28 -0700 (PDT)
Message-ID: <c354fc88-7ba8-4b1e-b18b-6becf7d74821@linaro.org>
Date: Fri, 31 Oct 2025 14:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] crypto: remove redundant parameter checking CA certs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030144927.2241109-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 30/10/25 15:49, Daniel P. Berrangé wrote:
> The only caller of qcrypto_tls_creds_check_authority_chain always
> passes 'true' for the 'isCA' parameter. The point of this method
> is to check the CA chani, so no other value would ever make sense.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlscredsx509.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


