Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E18BC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woR8I-0004L0-HZ; Mon, 27 Jul 2026 15:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woR8G-0004KX-0V
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woR8E-0002XK-F8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785181017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8enDtt8cqW6+NfaeAchD/r03eS4yL17OiwkOLzPRv3s=;
 b=ONTxhwbzDiq8gwTx5+env2sJTVqEl7gDwXN7gHUPXhqJkZ3mbEbMT5wpZo3HlL2he8f4XA
 Xa/0WRgHmadkAmpjnRcTZJhGmsXu2isABwzkSUOIqvPTr7pyshnc6qPezbliy95toCsYAk
 9NAUiCC2lkjsx9/m/svp6D26xpi/3sQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-YNicFfhZPbKh_mFzC8sh7A-1; Mon, 27 Jul 2026 15:36:55 -0400
X-MC-Unique: YNicFfhZPbKh_mFzC8sh7A-1
X-Mimecast-MFC-AGG-ID: YNicFfhZPbKh_mFzC8sh7A_1785181014
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so24053515e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785181014; x=1785785814; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8enDtt8cqW6+NfaeAchD/r03eS4yL17OiwkOLzPRv3s=;
 b=qPVNYm9isEG4sSouIEROcDk0cN4W7BWCbpWVCq0MYpxhnYqKhfNULmBYxf+PzfFXRt
 BrLD2IJZhksungXwXDjWe3oBb+ki5GW6BW2/sOvgZFzce7NDDgxGKYT4/DscNwL3XIZd
 easajPqq7rQKVGHfTErdhU6yf94oe1KGttFBuk0gU0H+R/830ohxZ4T1Kd95F9cVN+Id
 whpalEaV7k37ZaniAQeYJgVjef6vZIAMEiFfrAAbTq+wjANH1fyJMIGxUfEiLC2SMcPp
 Dw1fx2lbckHZdNl8TKPIMp44A+dJ2uPS7QW9e18lzRVh8YayG2fKf7gz724WkyMarP1n
 PFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785181014; x=1785785814;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8enDtt8cqW6+NfaeAchD/r03eS4yL17OiwkOLzPRv3s=;
 b=gpitPndibMpDXB3CeIVjd0mtPJAy1oWuyWUEDCRvz+y+oPQUyxqY6xK1V36PYhmN9o
 lieeFqFf2FhHNDeEZB7vJ/ZTmAFLPRp15/Sh7dhMj8tvXAFdELXB5uErmuHhT7kGd1ar
 KZdF5vjViCMUJOwG2n0ywXs9amazLbE1X0HZHG7zQ4H1keTpVvsebujfN8nbkUJKGRL7
 HaixqYLuLXovbdZZ6xOUhRhnvsM/YNDNLsSzOwRVpfe7D4vt1SfSaPIrSMQc+zcNFtlW
 pPJqx35bdSQGej+XwWTccPeNkFqrTS3pse1ULn8j+9GaiyCMi06830qL+66QaEaE2Etd
 aDTg==
X-Gm-Message-State: AOJu0YyL/hojFKp3HngI8tAck71yarCq4RCPHJ/3PuCGHIyqwlhKQyet
 peRJ/M1gYHTk35FWLIaFeaAaF7ruydIfpVLbY1blYB+5+dsqtJW4YAucYy8BjQOiv66U3hCx08e
 pI5eQMYBBTnFfEyMQUv6Ov+QJUvLxsAEHI9k1BUu1Xr/3audB/aO+wGPQ
X-Gm-Gg: AR+sD11/235O4/GtqA7ccHQhmJmx3GVLCUHQZgpOClD+k1WpUqG4z+YikbfuJDvphvO
 +WwsCByXbC4Mf6beeZcn8dhUcTodWc9GlRyzgt8zKzQkJk9zqqabtWFaCWxdWIABAY+m0HE5BUE
 TvhekeWhUYaHdEpJM+qFMF1d8Ksma/cZBvC3K2tCFYjd7DHG3S2MJzKMJ5Cd+oczJEvqFp/toVW
 lWJqpaZOnxn7co0YMyF54TF++xBl4NCXVbwvs08h3ASssvkjnFudRebwOAqpmyxL0hP/X2fqeeu
 PpQXJCJ5hTXSMdBxVAYzakWgiWs32KE2hBONYw7zMLOKxrEi3+mIrTlQzBiGpwQqTzCjmidhRQk
 Qa+5Mpe9Xgcr9Y/dBJT+R/A==
X-Received: by 2002:a05:600c:1986:b0:495:5943:b76c with SMTP id
 5b1f17b1804b1-496c4fe1f75mr4131185e9.34.1785181013940; 
 Mon, 27 Jul 2026 12:36:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:495:5943:b76c with SMTP id
 5b1f17b1804b1-496c4fe1f75mr4130955e9.34.1785181013441; 
 Mon, 27 Jul 2026 12:36:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bfe07e1sm252109975e9.3.2026.07.27.12.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:36:52 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:36:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 03/12] block/blkio: fix compiler false-positive warning
Message-ID: <20260727153554-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 27, 2026 at 12:44:02AM +0400, Marc-André Lureau wrote:
> Under some optimization, gcc produces a false-positive:
>     ../block/blkio.c: In function ‘blkio_co_getlength’:
>     ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>       943 |     if (ret < 0) {
>           |        ^
> 
> Replace WITH_QEMU_LOCK_GUARD with the simpler QEMU_LOCK_GUARD.
> 
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>


or we can disable erroring out on these warnings with these "some optimization" options.
the warning in question already questionable at best.

> ---
>  block/blkio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index 52a8be220d1c..4801339f98b2 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -937,9 +937,8 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
>      uint64_t capacity;
>      int ret;
>  
> -    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
> -        ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
> -    }
> +    QEMU_LOCK_GUARD(&s->blkio_lock);
> +    ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
>      if (ret < 0) {
>          return ret;
>      }
> 
> -- 
> 2.55.0


