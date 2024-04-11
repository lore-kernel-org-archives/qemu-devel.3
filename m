Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515C4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv12B-0000L1-KW; Thu, 11 Apr 2024 16:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1rv122-0000KV-5b
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:28:26 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1rv11w-0001O4-AA
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:28:24 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4VFrqZ6HPcz8PbP;
 Thu, 11 Apr 2024 16:28:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; s=default; bh=+mVxElw3F
 3vGv7MRJO7lNmwCvF0=; b=Ti8UG2qKXpytDiEy7/69VVbdH0EYYa2KhXK8kpsnp
 QEGH0HsvHSoRS29lV+DD7/7sI9d+MAKiv5WV2nbahWd0E34oDpamHm04ymhx4ZD0
 Ehjww1SspZaGFS4awjBH06viIIoiqLNOcDgFpfzMAfvUzM4qwPl0xJxFTthoWpmo
 Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=ctQ
 3dEcylL4o5rVdGiwj8MlFMzIUzH6ff6RBpShODc/nUv9yHuvgMQdUIEyLio/zjRw
 Hinn4ENGgMwUHgyjJg9y51WPpwuU4CGlF0zHG4OFhbKi1EAodHlGOdNP/GAzafG1
 UhG6NXxFvPw/aX1THiP73HUpY8zDhO/G+8QOKn7E=
Received: from [192.168.100.147]
 (ipagstaticip-fb0cb5d9-e423-dda2-c442-adc5999de965.sdsl.bell.ca
 [76.65.209.165])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4VFrqZ5FLzz8PbN;
 Thu, 11 Apr 2024 16:28:10 -0400 (EDT)
Message-ID: <1ff86ac9-917c-4703-85c6-c1e5bf3be79d@comstyle.com>
Date: Thu, 11 Apr 2024 16:28:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH for-9.0] meson.build: Disable -fzero-call-used-regs on
 OpenBSD
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240411120819.56417-1-thuth@redhat.com>
 <1ccea33f-23cd-4beb-b6d4-8bdc9c623dd9@redhat.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <1ccea33f-23cd-4beb-b6d4-8bdc9c623dd9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/11/2024 8:12 AM, Thomas Huth wrote:
> On 11/04/2024 14.08, Thomas Huth wrote:
>> QEMU currently does not work on OpenBSD since the -fzero-call-used-reg=
s
>
> That should be "OpenBSD 7.5" ... older versions are fine since they=20
> are using an older version of Clang that does not have=20
> -fzero-call-used-regs yet, I think.

About the compiler version that is correct. Between 7.4 and 7.5 we=20
upgraded from Clang 13 to 16.

-fzero-call-used-regs=C2=A0 was added with the 15 release.

https://github.com/llvm/llvm-project/commit/deaf22bc0e306bc44c70d2503e936=
4b5ed312c49

Retguard is also used to mitigate ROP exploits and is enabled by default.

https://www.openbsd.org/papers/asiabsdcon2019-rop-paper.pdf


