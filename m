Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C93CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIdVi-0004Bi-P2; Sun, 18 Oct 2026 22:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xIdVh-0004BF-8r
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:54:01 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xIdVf-0003yF-NI
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:54:01 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4j7Kqz4C5Lz8PbP;
 Sun, 18 Oct 2026 22:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=default;
 bh=ZDf3AJKCcdCd6PugB0v2iq9sT1dSJJ1l+6mOAHt7NFE=; b=FgTUIOpNY9D0
 cejO8Dxq+HXyR1RGubtBGuZVB2F0MF7fP6bpCU8FmfahMucHJN5nRXISTlEQ6TyZ
 Vyj6DWJ2DB9fuFAsUvD1kwowrXXpVDqcPmCbvhwPtDxPdMXB9up3XrkIrZ9oExiI
 03nhP2nUxnUHq6pmCoV0OUeTSttNTcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=message-id
 :date:mime-version:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=oGj
 98i1kXGYFxUBQMvfgmN2CBjM3Wkwg/S29n+PjUie5veDv6JHLscG5uW3LKwWfTMW
 mHqwtpbBM8KHcFyh0Pc5VQWdiiph6zhLu+Pz/j9Myte/9YkRqrs0BDU9mbM99Rxw
 erHsPlXU+DkjMYKy/Zi29f2dNw3sj3MRJm5VXrE0=
Received: from [IPV6:2001:470:b050:6:c48e:93fb:c02a:e421] (unknown
 [IPv6:2001:470:b050:6:c48e:93fb:c02a:e421])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4j7Kqz3bLPz8PbN;
 Sun, 18 Oct 2026 22:53:51 -0400 (EDT)
Message-ID: <041cce96-07da-41ec-ad9b-eba5173d9bb5@comstyle.com>
Date: Sun, 18 Oct 2026 22:53:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/cutils: Use getexecpath() on OpenBSD for
 qemu_init_exec_dir()
From: Brad Smith <brad@comstyle.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr_ Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang_" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
References: <aqjqfifkq8gi0w4Z@humpty.home.comstyle.com>
Content-Language: en-US
In-Reply-To: <aqjqfifkq8gi0w4Z@humpty.home.comstyle.com>
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

ping.

On 2026-09-15 2:49 a.m., Brad Smith wrote:
> util/cutils: Use getexecpath() on OpenBSD for qemu_init_exec_dir()
>
> OpenBSD has introduced a function getexecpath() to be
> able to retrieve the executable name and path.
>
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>   meson.build   | 8 ++++++++
>   util/cutils.c | 6 ++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index cfac634cf1..0e07138b0c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3034,6 +3034,14 @@ config_host_data.set('CONFIG_ELF_AUX_INFO', cc.links(osdep_prefix + '''
>       return hwcap;
>     }'''))
>   
> +config_host_data.set('CONFIG_GETEXECPATH', cc.links(osdep_prefix + '''
> +  #include <limits.h>
> +  #include <unistd.h>
> +  int main(void) {
> +    char buf[PATH_MAX];
> +    getexecpath(buf, sizeof(buf));
> +  }'''))
> +
>   config_host_data.set('CONFIG_USBFS', have_linux_user and cc.compiles('''
>     #include <linux/usbdevice_fs.h>
>   
> diff --git a/util/cutils.c b/util/cutils.c
> index 91ddadfd15..b5d1d13e24 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -1091,6 +1091,12 @@ void qemu_init_exec_dir(const char *argv0)
>               p = buf;
>           }
>       }
> +#elif defined(__OpenBSD__) && defined(CONFIG_GETEXECPATH)
> +    {
> +        if (getexecpath(buf, sizeof(buf)) == 0) {
> +            p = buf;
> +        }
> +    }
>   #elif defined(__APPLE__)
>       {
>           char fpath[PATH_MAX];

