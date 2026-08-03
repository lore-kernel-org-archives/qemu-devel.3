Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B90FC55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 12:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqrlF-0001KU-53; Mon, 03 Aug 2026 08:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrlD-0001KI-4l
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wqrlB-0001tK-Gc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 08:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785760032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kI4s89XDYGPNsnyejJHNkn52INgL7JiA8hxwCbXttYM=;
 b=QkcNSVOePHIyjle+7QD2G1uZ+DoVAczWHOLFULHHvqmodhlu5qUWBSkBvgOVy9HNbgswWn
 2GKhIiXgQZi1It42vwIPNfDGN0M4Vj1EpSZZy6xR/mGxBlrFCxjnE81U2TFm5RO5qPMIXJ
 GswSKLVanxAG0xPtQLNWtIL2nkC/vJc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-yXS9TnvDNRSr3Mi8ZEhJWQ-1; Mon, 03 Aug 2026 08:27:06 -0400
X-MC-Unique: yXS9TnvDNRSr3Mi8ZEhJWQ-1
X-Mimecast-MFC-AGG-ID: yXS9TnvDNRSr3Mi8ZEhJWQ_1785760025
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8580ed9eso3366097f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785760025; x=1786364825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kI4s89XDYGPNsnyejJHNkn52INgL7JiA8hxwCbXttYM=;
 b=OcnF1oEGCnL1Lm5/eI3t1ZO8zPbbL02xsZpS3HjrsddiEVVXc/8HcZ+eg+AC53UbSV
 qDHkYWtHxzynP4tIGwfmO2ilmvCoKQXDs8hHN11CzIcR/b7V9OMfuUV4jYHtSmMeATj5
 XF/xW2zqezve5hm5wAF+8hLLWQXYvxaZNSzVbrWtvMnlnh45SSMac6TgUgKV8XKeIxJN
 NrtYo7MV5CAB6OALxj/mEYz8Qjkm19uCxFFQgzFNK7i7JK7JO3LfIwZY61APZc8efKgq
 eWADyfmXMxZ4xQWKWCTgeFQK6E3cKdw6+VAjxrlmaagiCyGWMZdAMYO9DGCMgFgwD72x
 tpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785760025; x=1786364825;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kI4s89XDYGPNsnyejJHNkn52INgL7JiA8hxwCbXttYM=;
 b=A3V/w5AGw0AdPzSqH0jMOkuborLW+64g61kWHcjXbW2GggjV7MCMNXlGIrEcuwYTNk
 YhiI/UaR3Io0pDjqIDG4sgSvgf8VlmYzCUheVrMBdjRAw4ncSCyKe1b1n/TgXtI9TGvF
 +Hg31NhfLmoDmUglcFe2buZeY6zQbu104gH1jVJ2qUhGOV76ueCKY9uEGRH8h1rJLJlk
 y9+u2rY6lr7OVNNGVaDsYjpXzL8khErrIggZ1ZfiYJccjPyQxh3eYnirgwsl45VZ+Eyv
 79mfqnx/jb7GhuSbhT197muXz1HY9yjrFGd1juo61cvN5D0J35qdx3jS6oNIqhF5DCJn
 +KGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0iuccb6VhGRyy1ZxXu91Fy9YMph7zooH4APC1QrhCI94htpl87phxCUYqQrljrBU6aiFq1Prd5j7k@nongnu.org
X-Gm-Message-State: AOJu0YyAREjjL8z7Mq6S4/f7oDKMSGTR08hlYfgDQvCTbX9eHsKapGu2
 XF+1ZiB8VfQ1NnLtHV4EnNH1PlpjkaTloGoWB/cBMR79/mVSwBCbpFR9VOAr+2eeyqfwK+8dHQJ
 qSQ3KjcBepE4nGovOjCFLxShSX9TV0Rv7k4pX3beamL07wWm1WpKQUO7Z
X-Gm-Gg: AR+sD10v+YXoQf+AzWYs5MFLGlxr2uAWM7kuo41nva3ZAGfLLUFx1nVuphQxD8Jf73i
 u7T0ixPa+lpj4pOO4qKPEkdIl6jJY3HlEwwBItDiEyjGR0lpaHExQ76ELZga5m74ErwhwpCoWkD
 tfBv+2l1TKPqmZNij34HMGL2eD8MHSL3eZavkZ7G3XFHYik5xR5OhV92sY2967ncGPSwO5ZBwkk
 G4ShzEP0LYJwkROsIgB1naN5wuKFTHJqimSMkcSfU+AfZdMkNA/fapWE+NYbgb2C/bvm6BXG/ON
 nvJHg5B26cwctJ+QudZQHsFcpM24W4fYeM9gUNKolvBoKZoTp+6BsbYzsm1g+/17NcrbIllBUYm
 frZYee1GvbtllT+5ttNlgsng/Tx4C2WyhXqrbrZO0c0bancgSiS17Gxex+XEP2RsqOz2XsLY89r
 27P1KCYYSse8z3IDiHCTbEb1qAug4vPA==
X-Received: by 2002:a05:6000:43d4:10b0:47f:90df:4ec6 with SMTP id
 ffacd0b85a97d-47fd72a00bemr21145774f8f.6.1785760024816; 
 Mon, 03 Aug 2026 05:27:04 -0700 (PDT)
X-Received: by 2002:a05:6000:43d4:10b0:47f:90df:4ec6 with SMTP id
 ffacd0b85a97d-47fd72a00bemr21145611f8f.6.1785760024284; 
 Mon, 03 Aug 2026 05:27:04 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:549a:e584:7c7b:2611:32a1?
 (p200300cfd73d549ae5847c7b261132a1.dip0.t-ipconnect.de.
 [2003:cf:d73d:549a:e584:7c7b:2611:32a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0ae0sm33696154f8f.33.2026.08.03.05.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 05:27:03 -0700 (PDT)
Message-ID: <6f915ae4-f9b7-4e27-9c3a-3a99917b499f@redhat.com>
Date: Mon, 3 Aug 2026 14:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/15] net/vhost-user: add memory isolation
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-4-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-4-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24.07.26 00:30, Connor Kite wrote:
> Add a memory-isolation property to NetdevPassOptions and
> NetDevVhostUserOptions in net.json.  This property will
> be used for vhost-user devices to disable access to guest
> memory from devices.
>
> It will be passed into vhost_user_init() in a future patch.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   net/passt.c      |  7 +++++++
>   net/vhost-user.c |  4 ++++
>   qapi/net.json    | 15 +++++++++++----
>   3 files changed, 22 insertions(+), 4 deletions(-)

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index 1a6382825c..4588c7014b 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -213,6 +213,9 @@
>   #
>   # @param: parameter to pass to passt command
>   #
> +# @memory-isolation: enable memory isolation.  Only has effect if
> +#     using vhost-user.  (default: false)
> +#
>   # Since: 10.1
>   ##
>   { 'struct': 'NetdevPasstOptions',
> @@ -250,7 +253,8 @@
>       '*ipv6':               'bool',
>       '*tcp-ports':          ['PasstPortForward'],
>       '*udp-ports':          ['PasstPortForward'],
> -    '*param':              ['PasstParameter'] },
> +    '*param':              ['PasstParameter'],
> +    '*memory-isolation':   'bool'},
>       'if': 'CONFIG_PASST' }

I have a gut feeling there ought to be a better way to add an option the 
only works for vhost-user, but maybe not. I certainly don’t have a 
constructive suggestions. :)

(Apart from that, my only comments would be the QAPI “since” field 
missing, as Markus noted on the previous patch, and the patch ordering 
Stefan has noted.)

Hanna


