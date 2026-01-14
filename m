Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28538D31A29
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxCZ-0004Ss-8y; Wed, 14 Jan 2026 04:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfxCX-0004PV-Ei
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfxCV-0003Fb-DV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768383001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZIE1GGbLPZTQ4heJXk1ojwL4Df1Pyfx0tQSJjvJo7iY=;
 b=I2h6QdpdH9Tv3heuHzgb0j4NfV3b9XLIAEv9bTWsD0ehdrs+ckL4toF4tjEvNKywjfnT3x
 mIBJZ9yMv7OsL7BYtTkFBIf8Xenw/g/lhAAqnxLq4gzUP/o+CjQpSqMw8lqsMO4a0GPPXX
 6L/aKjJw0dzF8GW3XPvu0bHY1j3iCac=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-0feEf5ydNMCPqu5gpCIiIA-1; Wed, 14 Jan 2026 04:30:00 -0500
X-MC-Unique: 0feEf5ydNMCPqu5gpCIiIA-1
X-Mimecast-MFC-AGG-ID: 0feEf5ydNMCPqu5gpCIiIA_1768382999
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso55388545e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 01:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768382999; x=1768987799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIE1GGbLPZTQ4heJXk1ojwL4Df1Pyfx0tQSJjvJo7iY=;
 b=hS/OBc/SvsiVNiLuPzmUWGuZuZ6+PR68UEz3AoI5WimOJoViB7uqDAoyAizZmwY0I8
 svUzofO6twuFaCxYLVwK4lKRGBxmS5mwq+1jwB1dBHgkhiDKZSbUkJTARbBtnRqRPhwo
 iUOu4GZpUL69cIJvZ+nuOV8cR/o4x3RQkVvMgLUCW4K0/X3M2YTaxUR3ZqTWSs2jfpG2
 W6cDSuuvp5FTQ/PTc2R2ZiCBOQpMa11IDoPO/FKznAiQQmgO1+S5wkOokdL0F60Ucmme
 yYGRt2YIX5KtNGzIXddZPCHh9McBUxTipkyVFONl0Xe//aVkvbqqH46pHk61uY8uOg4T
 LJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768382999; x=1768987799;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIE1GGbLPZTQ4heJXk1ojwL4Df1Pyfx0tQSJjvJo7iY=;
 b=FUqQf4sY6nViXgHwE/e/U8Uz2ItvSVqn4VljU+SIcjC3hKm6VIg7FWU3JHHRSGWxt1
 KirDXGof+AWWxWSukMhM7l0xHskSbOl3bvkKv9lY6AGeDBGr47+ql+txpbYxeLR4ItxI
 IkP26ZmRKJ6XI2B7CwcVnh9r7LnVoaUXUYWFfGywvDSbS6tEglcW962fh5A3ORbmiDRT
 5x7x+wqaly0Y5U2I5BNe5TPF4tDkA6xrFIFVDCy5oE00Rz6bjHHgggVGjxINrMkFzXsf
 a83P96jUdKEvTxA1fH0Sww/vkstQZ9JiMVLebJp88xFolehfoEp5v9u5xMEHJLvJ8bf6
 s9fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqMzdscl8hecA0nHrpArQeRCrF0X0B8FJDO0cfPIyIACOd/WEc1mWFokTTZAOqq1+4bAB7JwPMLvvk@nongnu.org
X-Gm-Message-State: AOJu0Yx2RyDWolOGI6vVKP2OrZoWFYDg8NupK+YqZ0Lur6UkxuUSUKCu
 ScdephF64KFpceNQwydbRvyCjLW/srwllHhcFjCD9fKTtod/jxvzw5AJCvpCSWrt3tnFKFW4kdA
 kIIzRUE/ALnPRxNvUyFezqXIwR8EMJn9OHx5QPLDUctiGG5fLyubK7gtP
X-Gm-Gg: AY/fxX76hAcv2cvJT7o1Pw/SikoTRbd7GjgJx7V6Gwe5lvlARaNWtB85h+polfV2nSA
 rsjfT+ozSpoEdatAzL5RXhB2qeFI5U/AbSzrhWQlfEjBXP2OLbtoD9BUdKjy4xGCWxe1aaC9eqd
 iP6jumYWj0jgH0SBHs+3SU02UaSU/trOXUwtUdy874iVPZ7ZO+fh5GU++vexLVY2yIAHJXZne2C
 PbLST9YiEXSpnNgOE05llM1ywJ9Uma9vO7l+ibCwkZoQOx+avxPwamcoqZIQD8ctkzhf+noc2QV
 5/9GtCnAKwlPc42aR9aC7z/9oA7G7nIR6QFiJVFL9kFXfMJsSJw1pTMLkcOh/OdrUj4r6mx9MqP
 e3weEgXFQ3Ei1Jxo0igUmu0/9pdauXDjTwxkSbNehR2dzv1k9QQ60VqXDi+NX/4F/Q/QPX4pJvn
 CH0lZXyhzZLp7/qg==
X-Received: by 2002:a05:600c:a46:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47ee338c00cmr23778005e9.35.1768382998626; 
 Wed, 14 Jan 2026 01:29:58 -0800 (PST)
X-Received: by 2002:a05:600c:a46:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47ee338c00cmr23777645e9.35.1768382998190; 
 Wed, 14 Jan 2026 01:29:58 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47ee28144aasm15769315e9.11.2026.01.14.01.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 01:29:57 -0800 (PST)
Message-ID: <1945c9e4-b970-413e-a754-5b1b500b5758@redhat.com>
Date: Wed, 14 Jan 2026 10:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tracetool: Honor the Python interpreter that
 "configure" detected
To: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>
References: <20260114092358.22961-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260114092358.22961-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/14/26 10:23, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tracetool tests currently fail if the host installation does not
> have a "python3" binary (and you compiled QEMU by selecting a different
> one during the "configure" step). This happens because tracetool-test.py
> executes scripts/tracetool.py directly, so that this script is run via
> its shebang line.
> To fix the issue, pass the right Python interpreter to tracetool-test.py
> via the PYTHON environment variable and use that to run the tracetool.py
> script.
> 
> -    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
> +    python = os.environ.get("PYTHON", "python3")
> +    args = [python, tracetool, f"--format={fmt}", f"--backends={backend}",
> +            "--group=testsuite"]
>   
>       if fmt.find("stap") != -1:
>           args += ["--binary=qemu", "--probe-prefix=qemu"]

What about just

diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 30006a99190..efc518a6b1e 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -36,7 +36,7 @@ def test_tracetool_one(tracetool, backend, fmt, src_dir, build_dir):
      actual_file = Path(build_dir, rel_filename)
      expect_file = Path(src_dir, rel_filename)
  
-    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
+    args = [sys.executable, tracetool, f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
  
      if fmt.find("stap") != -1:
          args += ["--binary=qemu", "--probe-prefix=qemu"]

(only the second half of the commit message needs changing).

Even if you keep using PYTHON, which makes sense, I would change the
default to sys.executable.

Paolo


