Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED340EE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9Jt-0002Pr-C4; Tue, 10 Sep 2024 18:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1so9Js-0002Ks-8Y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:26:44 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1so9Jq-0000Ab-DV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:26:44 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4X3JFr3F6yz8PbP;
 Tue, 10 Sep 2024 18:26:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=X2nIY0zuvvfUu9qLEGzHCAYEK+xeJJzkC2ZusOZKZfI=; b=XN3goz7iveoG
 xtre3l3iblUAG7WuOezPE9gnGBM0UrvMvbcsChhnxHRnwYytWWCHxdAIBjmpwEaB
 KaHNwKyb/nCr0RtCywPvBqiD/ofueN9WCo+fQqoY4uV0qJG+Xv6n/3JP6ziKzyK+
 PeEiJFzdEh39+kz/llavcDS5Htc4Nl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=E9c
 1MQkfpyj4PpL3Er7LfYEWOJJS9Xa4PHWVwx5FThu8ACZPwwx0fH0TkwKwIAqoEAG
 L5jDDJhqFpMfvX+6yLiYPu4qUH7Ig0rTX2wAKLQd2lIZMOnDjAg6w1lwVX8y1j0U
 h7JH4Vx9n+X76DURKPzYxi4RKwk4RKUyBuXOKnqI=
Received: from [192.168.180.2]
 (ipagstaticip-fb0cb5d9-e423-dda2-c442-adc5999de965.sdsl.bell.ca
 [76.65.209.165])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4X3JFr2TlPz8PbN;
 Tue, 10 Sep 2024 18:26:24 -0400 (EDT)
Message-ID: <1823ff97-b305-453b-b3a6-b24cc1987002@comstyle.com>
Date: Tue, 10 Sep 2024 18:26:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/qemu_test: Use Python hashlib instead of
 external programs
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240910201742.239559-1-thuth@redhat.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <20240910201742.239559-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2024-09-10 4:17 p.m., Thomas Huth wrote:
> Some systems (like OpenBSD) do not have the sha256sum or sha512sum programs
> installed by default. Use the Python hashlib instead so we don't have to
> rely on the external programs.

On OpenBSD they're named sha256 and sha512.

> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
> index d3be2aff82..3ec429217e 100644
> --- a/tests/functional/qemu_test/asset.py
> +++ b/tests/functional/qemu_test/asset.py
> @@ -43,15 +43,21 @@ def _check(self, cache_file):
>           if self.hash is None:
>               return True
>           if len(self.hash) == 64:
> -            sum_prog = 'sha256sum'
> +            hl = hashlib.sha256()
>           elif len(self.hash) == 128:
> -            sum_prog = 'sha512sum'
> +            hl = hashlib.sha512()
>           else:
>               raise Exception("unknown hash type")
>   
> -        checksum = subprocess.check_output(
> -            [sum_prog, str(cache_file)]).split()[0]
> -        return self.hash == checksum.decode("utf-8")
> +        # Calculate the hash of the file:
> +        with open(cache_file, 'rb') as file:
> +            while True:
> +                chunk = file.read(1 << 20)
> +                if not chunk:
> +                    break
> +                hl.update(chunk)
> +
> +        return  hl.hexdigest()
>   
>       def valid(self):
>           return self.cache_file.exists() and self._check(self.cache_file)

