Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E704ECD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdDJ-0004MJ-EV; Thu, 28 May 2026 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSdDG-0004JM-Ft
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:04:02 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSdDD-0003vr-8x
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:04:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 609B9807B5;
 Thu, 28 May 2026 19:03:53 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:74f::1:5] (unknown [2a02:6bf:8080:74f::1:5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id p3dPTY0ZUGk0-ubvyFX2f; Thu, 28 May 2026 19:03:52 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779984232;
 bh=HbTSe8ucO420LVNE5atia9qLYbG/+3H1Y9cvL3h9Q9o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BbP1tU4Da6I39UUEDU1OtPlRkIfvBM3R1WUtlH1hDiwOXgKy+K16b6zcUq+S9Bgle
 GCaQIXKrirl4LgJW+RBWtmTY3bL5+mXLZVB7NtZ3tBR1G7SbFCxNZkVPAUhWGLx5QL
 tcOVatfYlUzDeLJ4UoKYrsZHWgWe7ozK62Et40L8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4de9782f-0b3f-4f37-9d07-e02a7928bb94@yandex-team.ru>
Date: Thu, 28 May 2026 19:03:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/10] net/tap: support local migration with virtio-net
To: jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>
References: <20260527191150.250333-1-vsementsov@yandex-team.ru>
 <20260527191150.250333-9-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260527191150.250333-9-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 27.05.26 22:11, Vladimir Sementsov-Ogievskiy wrote:
> diff --git a/qapi/net.json b/qapi/net.json
> index 1a6382825c5..c5d87ba308b 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -425,6 +425,22 @@
>   # @poll-us: maximum number of microseconds that could be spent on busy
>   #     polling for tap (since 2.7)
>   #
> +# @incoming-fds: do not open or create any TAP devices.  Prepare for
> +#     getting TAP file descriptors from incoming migration stream.
> +#     The option is incompatible with any of @fd, @fds, @helper, @br,
> +#     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
> +#     @downscript be explicitly set to nothing (empty string or "no"),
> +#     and requires also @local-migration-supported to be true, "local"
> +#     migration parameter be set as well, and QEMU being in incoming
> +#     migration state.  (Since 11.1)
> +#
> +# @local-migration-supported: enable local migration for this TAP
> +#     backend.  When set, local migration is enabled/disabled by
> +#     "local" migration parameter for this TAP backend.  When unset,
> +#     "local" migration parameter is ignored for this TAP backend.
> +#     (Since 11.1.  Defaults to true for MT >= 11.1, and to false for
> +#     MT < 11.1)
> +#
>   # Since: 1.2
>   ##
>   { 'struct': 'NetdevTapOptions',
> @@ -443,7 +459,9 @@
>       '*vhostfds':   'str',
>       '*vhostforce': 'bool',
>       '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*incoming-fds': 'bool',
> +    '*local-migration-supported': 'bool' } }
>   
>   ##
>   # @NetdevSocketOptions:

squash in, as discussed here https://lore.kernel.org/qemu-devel/ahhGBuom-GTfouRA@x1.local/

diff --git a/qapi/net.json b/qapi/net.json
index c5d87ba308b..a71dc7f1d4c 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -441,6 +441,10 @@
  #     (Since 11.1.  Defaults to true for MT >= 11.1, and to false for
  #     MT < 11.1)
  #
+# Features:
+#
+# @unstable: Member @incoming-fds is experimental
+#
  # Since: 1.2
  ##
  { 'struct': 'NetdevTapOptions',
@@ -460,7 +464,7 @@
      '*vhostforce': 'bool',
      '*queues':     'uint32',
      '*poll-us':    'uint32',
-    '*incoming-fds': 'bool',
+    '*incoming-fds': { 'type': 'bool', 'features' : [ 'unstable' ] },
      '*local-migration-supported': 'bool' } }

  ##

-- 
Best regards,
Vladimir

