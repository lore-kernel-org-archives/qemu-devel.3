Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0353BCF256B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 09:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLeUy-0001wu-FR; Wed, 19 Nov 2025 04:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLeUx-0001vm-1S
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:29:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLeUv-00028F-LD
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763544549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZVDerVyCDLbjkbBuakWXcoge1xfdPcmnBaFdNfFZc2c=;
 b=QntkGYOgYLvhtedcdaOA7gAVu2VW5Y4zfi/ouKsLNNlgBRmuRiUAXscgP2AC6Qwfm4lGWj
 iOJO76n0mUUO5YtbItgE13PH0whP4yYXpfrxHsPfaHfl4rEoNmg31AHmFiCw12KBAe8sMR
 b4yvIHBRY23RSGJFWDJw321gO62fRtw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-rOQZC9HTNjeC6LaR9034hA-1; Wed, 19 Nov 2025 04:29:07 -0500
X-MC-Unique: rOQZC9HTNjeC6LaR9034hA-1
X-Mimecast-MFC-AGG-ID: rOQZC9HTNjeC6LaR9034hA_1763544546
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b3c965ce5so4361099f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763544546; x=1764149346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVDerVyCDLbjkbBuakWXcoge1xfdPcmnBaFdNfFZc2c=;
 b=j+O1/U6CUGp3czR4mVXEe12inHxWd3J7efrQ57qRsovdMb30sBI9A1/6/CCZ6u9yW0
 DKvTI5QzW4L1gf0RZqiNjlLiaXCbwKXeYZnpeTd/hzEUVMHCHOzkb9g6tY+yeLuVOutN
 vxphiA/oYOpZOn7SQ7FAm8zR/qN5XyQx8vJqsf4dYDM2EErReGLSLOsHTeI1nGgJ4Dwj
 jzhcYz67lp2Fh4dixFsztYjFjOar1eea7/iSglvKd7w25/exPb9mmDxQsefFs6S4XYNN
 q7Qqd1ujw6O42A9VRsxw8aU2Pr1fbZOgdpJ+3ES6JygumrLTC2e802oQqf+pEQxiFywJ
 CHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763544546; x=1764149346;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVDerVyCDLbjkbBuakWXcoge1xfdPcmnBaFdNfFZc2c=;
 b=UJ6texpnCvZL+WJy3S8iJEGIiKKoHt6D7f5tJR+RmeF3QG4Itw+Xu6DyykqPmJ269d
 s9mPkG/JMuvXZY3r+bs+sQHgTvCFswCg4yRSWsp9sbCEp3a/FI2BNMf0h61DIL6i/L3O
 lduAFfF4sF3MxSQs20fZ4/ESqOs+oYZBEghpezbbRl/RWEOj0bjKLv4CkBiphrQMuKsx
 Ot1VTKpDOGZRA2Sp3KwvCfWfQQ6DF2kFd1Arm+uhJJsYtkgkW3yJHluxH/NDCDXp2qZx
 vQaUMRKsUFa/2D2oL+PMgnM7iM+Mlsb7dJLYV05xBZD2YCr04YzvByjhHHD2AqXpBDYr
 y5Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7qioKYyvG1n37ZmTb+K3XgFTqUJAmE4zK+ijGtF7110e6EITY0RtU2a5itHUn1r5XxkVPz4EMjGQb@nongnu.org
X-Gm-Message-State: AOJu0Yx0MVRyRGy/0G3GqOy0mMaHslP9BlwmiiqVtpSY2NHletbc5Cb1
 ZFOsWmhlR3zSNitKHVj+Q45Ck2Qfsiduzy5DjZ0IUXI0htS0FoPfieCNnIR8KssEmGqYLTopeiK
 iZQXOKFbfzw4Jnf9xCj+CPBvcS3HVYLn7FSv0uconblrNa95wIKU/pday
X-Gm-Gg: ASbGncsMOGG4p6Kfx39Nsq6bhvaqjwufAOnomgZEpkOKtITm7zvZrWrUCJbicFU+uk5
 oGvMOFTzV6qmJ6ZXY0vQnBcJqZOzjK/BuWsB2eIRZL3WGPLByfTmYDVuLNT+5r2fVWyI8cjdKkN
 V+mR1OmlDBXgilGovVv7BrPyKq2rOl3gh4sRG4u/1uZHA/O1tufMAEbI66+CZY/LHosWQoKxOVe
 qiAz4sZPiS1gBsOu0O/sToz/unzVGbcwmHVlCJZxH5rmK3Myy+QvyHYRX86gWqZPpPHimKKLN6b
 DWCbj9O7y5ChDUG0ikIRE04H5TAps8Ciq23CSXZHFfdKt1oTTEJxuzS7IXAsZlrWF3eAOX73uEU
 RU2kBj9wNbsix4V2i/0CVpnrS1LJd5Fa/S7I=
X-Received: by 2002:a05:6000:288d:b0:42b:5567:854b with SMTP id
 ffacd0b85a97d-42b59394d6cmr18325088f8f.45.1763544546163; 
 Wed, 19 Nov 2025 01:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXZi6uN/wHs6FM99G6JOgcuOcUrOWxdTxbP4aEsYMjg839tz1nU8wCw3BXUdz0DaR79jCqiw==
X-Received: by 2002:a05:6000:288d:b0:42b:5567:854b with SMTP id
 ffacd0b85a97d-42b59394d6cmr18325051f8f.45.1763544545741; 
 Wed, 19 Nov 2025 01:29:05 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm36535557f8f.9.2025.11.19.01.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 01:29:05 -0800 (PST)
Message-ID: <5858b3a2-f92a-4dcd-b401-585250821032@redhat.com>
Date: Wed, 19 Nov 2025 10:29:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/22] python: add vendored qemu.qmp package
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-12-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-12-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/11/2025 19.51, John Snow wrote:
> In anticipation of deleting the python/qemu/qmp source from the tree,
> add a vendored version of the qemu.qmp package to ensure that "make
> check" can be run in isolated build environments, offline.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/scripts/vendor.py                      |   2 ++
>   python/wheels/qemu_qmp-0.0.5-py3-none-any.whl | Bin 0 -> 72263 bytes
>   2 files changed, 2 insertions(+)
>   create mode 100644 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl
> 
> diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
> index 33ac7a45de0..36cd27046e7 100755
> --- a/python/scripts/vendor.py
> +++ b/python/scripts/vendor.py
> @@ -43,6 +43,8 @@ def main() -> int:
>       packages = {
>           "meson==1.9.0":
>           "45e51ddc41e37d961582d06e78c48e0f9039011587f3495c4d6b0781dad92357",
> +        "qemu.qmp==0.0.5":
> +        "e05782d6df5844b34e0d2f7c68693525da074deef7b641c1401dda6e4e3d6303",
>       }

I wonder why I did not have to add pycotap here when I added a wheel for 
that...?

Anyway, for your patch, FWIW:
Acked-by: Thomas Huth <thuth@redhat.com>


