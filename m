Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7F9C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 19:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfmH9-0006aK-Jg; Thu, 29 Feb 2024 14:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfmH5-0006Yw-B1
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:40:59 -0500
Received: from bee.elm.relay.mailchannels.net ([23.83.212.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfmH2-0004rR-NM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 14:40:59 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 6690B4C1F17
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:40:54 +0000 (UTC)
Received: from outbound5c.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 81EF24C1DFF
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:40:53 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709235653; a=rsa-sha256;
 cv=pass;
 b=+Et7UrMcC42N/P2f83vhx+ouJbDdxmzRg9jl+pWRVaMPJ3rDkLyS1BJH1jWiHXGLQJvD18
 TkBYObOV3ivUlif7KXlw0v9gOs9F5s2BqqdTpiKnycN8KFz5pJliNoaVqvy9Ze/TDvvN3z
 fQgDDZZWV0555ZH4skXXExEx3sxKJ4yhKf/r4KL9bd+4HJ1Z5D9egrHG0JdnsPq28WHbvv
 kcy7bGj8HHVmh3z6Z8oSxhH7B9fDu8UKqV5MG8UMNnOB6hIdp2P6O7I5mFiMRkB9Ttplfp
 B1sKmVJ1oLIZumeFIwNTYSouY4LJmltw9yy6gmE8fmuk433RC80amSwO7Q/oKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709235653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=yEq79Pq1mGonL+xTBXea9WzwJtj6rvktG0gMcu+LSBY=;
 b=zr6GQuOKijjpJcYGrHHP3Jb0vT5vad4kVGaWvOck6kzD/eIXCidAyplfh+eRr0CpElAcrr
 Bztvmff2z4QFLTjwgpldEeJp2ukm8jgzsJFAoL6XU8+eKYi6kTUv9xhpBpPeC2EAhpTp+7
 wY/5mldKIVQDj1xiyydIEDoTyVYavGJPTckqZwhgBEeAaeoCex1epdycWHJm3F9DqxyVdX
 RKOYPe3EbbrC4Two7MW6mTuF9zslOFTW58Qe7DZJvluyQR3zig5ogngBpCdN4QrPGWeqCb
 OnsUTZcxZ9Xe4DsoZZz+El/fDIQp1xB2PLw52OJINX6EpUG0YxYwQszFyNMf4g==
ARC-Authentication-Results: i=2; rspamd-55b4bfd7cb-67j67;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Attack-Skirt: 2a7355a9352fb1f6_1709235654019_3267780164
X-MC-Loop-Signature: 1709235654019:584227320
X-MC-Ingress-Time: 1709235654018
Received: from outbound5c.eu.mailhop.org (outbound5c.eu.mailhop.org
 [3.125.148.246]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.114.53.127 (trex/6.9.2); Thu, 29 Feb 2024 19:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709235628; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=qBCVi0R/Lizjm8w7oCcZab30n1Z+CKRiaQOlm40/5ed9FKL6wQzhbyMclNp8zoDs5LQyRyqalhn5o
 0cC4YKjHWfqtJm+EFN8jloBjr1fY8VnEHzSNFoCFjl7KyLZAp62yOb6teN/J4PhRSeCUu8x+qU/YJZ
 4YMawAkluLRsep33ste0fRvkuqdHe5yweG3B/LFTC1sOxKZmM486FMpqxRkQosxC3mYanAGbMeQrjW
 OIu41gsc9DFCx8uiMB+0dsztcPG5SKE7j+vIYxEjBiJiiAVgTGExQaS0uCjEEHKK+YborOiXn9cVTF
 Ufgfh+WQFFHWavGsjuEJwonbzfTvtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:dkim-signature:dkim-signature:
 dkim-signature:from;
 bh=yEq79Pq1mGonL+xTBXea9WzwJtj6rvktG0gMcu+LSBY=;
 b=HaFW9psbAhsAyYqd7YL/ehOIhu7qyQDU9YtQr9PDCrDBjl9GCzFBUdcZj0IoHtAeggfS9mpyK3iL2
 zzJnd7gn1rNwrTNQ4J0LjQWA7xyG8BTqLTo9+WfvCk8SJEjseFymTnVGvK/nb/HKnvgZGuOQmSskPC
 8tbiWXnSZNeSnlEHBO2gixaOQ/Q2VddUrw2Uf1ANpsyuFDfJ3bG1nDrOaLwz4N15mAkHPkC5CGvdYI
 hv1lzElN0yIf04f7OtN5h1f8AIzp7g1+a1mQGQ+ytx5CVN0KIY0AMT9rVKCAMypg9vkP2Cb5SXmIRy
 +K5WbOPvQeRcTKCOWxrIJLQP6d9T5XQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Fvo6Il0j; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=yEq79Pq1mGonL+xTBXea9WzwJtj6rvktG0gMcu+LSBY=;
 b=i7n7fEFohxiWo+MjvgnxGVLwfIokaMTb0wclUm4Od0a7Olz6Zjqc2xdftMDxRiX+eUHRlV0GXNYb9
 /c9ZhRSvNleO+knYu5wArB+IDFfW0SDAeq9J4McdUTs7qqXl01GqQXkFr5j4Faeiv36vc/yA0EX8Zz
 /JF5TleT4McHrWzA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=yEq79Pq1mGonL+xTBXea9WzwJtj6rvktG0gMcu+LSBY=;
 b=JIP3epvA7OSfkB35jWkTUWL4iIgiKdd4PCck8QiNu+G8vw5fzq4dlPhdhIshMCxjX67KTgq99CJsu
 Fg4XRtQKwGc/TtNBrlz0l0mE68EiMuxroVWqy1VL44RYc6YaQ0XLWct7dLRxc/Vt90MZ9nC7w8Qmez
 cAA/16YEh37M5lfJIAWOQzeJJVlvh2YARxtBofadtn1R6w3ugIlXwJ1hcDhG2JWGwFvJfz0eQYGBtd
 gWWhwBnedg+v6JvlhSjLZ1NSnzl97A+cnE+K5Kf/zkf9aWgRVRYyHzvn0ILoJoDjFScxWn9cy6CFFV
 lkoekd+aTgZDSxGQ6T5DoKDLiyGBngA==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 6110cee5-d73a-11ee-afbe-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 6110cee5-d73a-11ee-afbe-eda7e384987e;
 Thu, 29 Feb 2024 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yEq79Pq1mGonL+xTBXea9WzwJtj6rvktG0gMcu+LSBY=; b=Fvo6Il0jbum2jKdge6ZTGWKEvV
 UCE0ZnXJjDtKDCvspG9vWiDGqmPMHoT033w1FC1tQEUcs/NftkWYOmO6BzvxS3lQ88UGo0L2reOKV
 3SOjDLkeMlubIQ5ftjnueZwHODj+TRWfHs68duvgdjpswwcMard1mngoGy/DE6aKHMnqN+SF/snPd
 PviQYBXmbkqBSRIeI7ONLDcprDvKMDI/qqUUntjzzit5Jd3F22a4PPPIQjeiszZAoiNwhmcR7ZAAn
 m6Tfj/ghTJfRfWvdQ/YXXc+Db7q/YMKdBtr2v/YctyZNvGELvson1HEboCJn3lKs0uByBqcqcZjML
 6sB6oUQA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfmGs-000Ncq-3D;
 Thu, 29 Feb 2024 20:40:47 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH 0/3] plugins/execlog: add data address match and address
 range support
In-Reply-To: <87a5nj6vwg.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Thu, 29 Feb 2024 17:08:15 +0000")
References: <20240229150729.1620410-1-svens@stackframe.org>
 <87a5nj6vwg.fsf@draig.linaro.org>
Date: Thu, 29 Feb 2024 20:40:46 +0100
Message-ID: <87cysfxdmp.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.83.212.14; envelope-from=svens@stackframe.org;
 helo=bee.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Alex,

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Sven Schnelle <svens@stackframe.org> writes:
> I think we've lost a patch in the re-posting. patchew hasn't seen it
> either:
>
>   https://patchew.org/QEMU/20240229150729.1620410-1-svens@stackframe.org/
>
>>   plugins/execlog: add data address match
>>   plugins/execlog: add address range matching
>>
>>  contrib/plugins/execlog.c | 95 ++++++++++++++++++++++++++++++++-------
>>  1 file changed, 79 insertions(+), 16 deletions(-)

Yes, i got a 550 mail. But i'll look into the qemu_set_dfilter_ranges()
before resending.

