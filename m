Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61552C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2xh-0008Dr-OO; Thu, 20 Aug 2026 09:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx2xf-0008Df-NQ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:37:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx2xe-0007hP-4O
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787233056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BhnoDnKvnaYfG8IrbmvI7a0r0hfFW0rqcKzmzr27vHY=;
 b=R+ivqOsjc58kCtCtuih/9rUSzEUp8yXL5j9btNSxXhi44803F+7x9VMY7ioWdaOK113On6
 NawbiLU+ZR3rxrJgW9Toj5mcbMO2iyO2q9tdQJ6KVxEUnZca9g+5gXacOo2qP1h6SFxPz3
 OlS75SKaNhxKNWOWk+j/8ypYGDVnje8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-vGs6zdthP8ab7DbuoL29Nw-1; Thu, 20 Aug 2026 09:37:34 -0400
X-MC-Unique: vGs6zdthP8ab7DbuoL29Nw-1
X-Mimecast-MFC-AGG-ID: vGs6zdthP8ab7DbuoL29Nw_1787233054
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6b12d7e6b0aso2018415eaf.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787233054; x=1787837854; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BhnoDnKvnaYfG8IrbmvI7a0r0hfFW0rqcKzmzr27vHY=;
 b=j9fcHsTNyMPD0GYgC2R4On62P4YEztcxAh1OMZdeT1nHSumz4wDxMBxE7970rbQzlV
 /6Qsw5pZSa0i1NzNOaBVCJ/ycB1otVVRhix1v9QD0y5snc+VGYFbFu83GIiMv5zvWZNX
 mGSuoTyC43QIdJJYGlAC9ZGYECkCpgcX4H780eneurCmd4WTBkeYCIzIin3eJ85N4oCm
 5k4jWKk9kOmfznVj6zmZD0IaAMhlRX2DwdAgI5uXaZvTxY0ae7Mj1SRTPuYa98gqKvdp
 oqM7z2PTHbcm0t7BGSnmkHNhq6OnBw9enWh+djyGdoW8NmNWjhub5fp0ujWEHZJuiHcb
 VjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787233054; x=1787837854;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BhnoDnKvnaYfG8IrbmvI7a0r0hfFW0rqcKzmzr27vHY=;
 b=HxCjA/Txbq7k2u9A8nXBz9kzczy8gS4KF9Hz/uKE9nGzJIt4c36aj4EqYKbkML82C+
 dJJwh8/1E8cUT+qkTag8KczIaBUTMzrv/G557XA4vfVVJBmYA/9EVMHG6i9WrukJ5GRn
 gh5uYMLJBk9MBcRNBCHMM6TCQmlXsZUKRif924dJCmHTuaJ08ZmdQlUasCsKmFX2JiOt
 MfrsHgjvqTBYtt4wYg+tgnK20q1xgDbLrdZbrgvq/joZI+1WlqFR9c3bLVnXawsOI5Ew
 LYA22doYkquZHSludeuX06GfGBfMEljOpsHS37bjd9wlETWcr3goVqpvGCXBNpHNHjkP
 gzPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgbTTkuV7HPQ0rrM0MkqPthxKtXFzt5cMPtzNKwuwUnOmmD21BB53CuyIcBhzJ/hS4nwBNEc/zuBMf@nongnu.org
X-Gm-Message-State: AOJu0Yxa+Wwvz7emq1UMDFvjC6UiYGefwheXGOITqEiBM1rwhm1FIC8B
 1yBJxHeA0h7CRxITqZy29Ch95heK/Nanuh0uh7Dv0+KDK4vYu/yObd2CSZTh44+8u4VMwnyqBjw
 tT5pE0LaYlqWkIwcN8b9UsnQPC5qA8o2WBO3m+czmmw8gGUhBiuYWBARJ
X-Gm-Gg: AR+sD11mOse1IouEpTdbBBNK2ht0069YNn/Ea+OCeDyF8OdEJy1eLkX1jcfsT0xD8ZG
 rKFzIS4LroOyLeciu3t9HZiKYhxpP5g8qShz0YuGvTWPSnp8ACFzP1qtblxWKI7MFHuheYA5CAo
 K2i5qAu3/CNpwLeISC3vcS9wfk+4nlRqEsK0z91CvcsQ0QRsI0iEwr1VEGS9t9JvjqjUmyKYIF6
 VCJuT45qqKlGpE1dDHjn7ZS49zpMyr6o3Z+b9u89yN63AWh5XsYKr178b1WJazuGTdI90D6ofQb
 KZQi7t+XywjZ5frdVTvb1EoYDzoRq1FiXHcOlSJCUKfLrAsvJal2C9Tgkv1mAz44w46J5A==
X-Received: by 2002:a05:6820:c8e:b0:6b0:fd2d:d338 with SMTP id
 006d021491bc7-6b13c6a76cdmr12379828eaf.36.1787233053896; 
 Thu, 20 Aug 2026 06:37:33 -0700 (PDT)
X-Received: by 2002:a05:6820:c8e:b0:6b0:fd2d:d338 with SMTP id
 006d021491bc7-6b13c6a76cdmr12379786eaf.36.1787233053462; 
 Thu, 20 Aug 2026 06:37:33 -0700 (PDT)
Received: from x1.local ([2605:8d80:6d69:ab3b:879:1f7:4951:97d9])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cebebc2sm4895056eaf.9.2026.08.20.06.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:37:31 -0700 (PDT)
Date: Thu, 20 Aug 2026 09:37:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org,
 farosas@suse.de, lizhijian@fujitsu.com,
 Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 2/3] migration/rdma: Post initial receive before accepting
Message-ID: <aocDGlrrUSluJWHF@x1.local>
References: <20260817105117.3072040-1-yanfei.xu@bytedance.com>
 <20260817105117.3072040-3-yanfei.xu@bytedance.com>
 <aoYBIaisgpP6lklk@x1.local>
 <1313593f-9468-4779-b74e-addcdd012e8b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1313593f-9468-4779-b74e-addcdd012e8b@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, Aug 20, 2026 at 02:22:26PM +0800, Yanfei Xu wrote:
> 
> On 2026/8/20 03:16, Peter Xu wrote:
> > On Mon, Aug 17, 2026 at 06:51:16PM +0800, Yanfei Xu wrote:
> > > The source return-path thread can send READY before the destination has
> > > posted its initial receive.  Since RNR retries default to zero, the send
> > > can fail and abort migration.
> > > 
> > > Post the initial receive before rdma_accept() to close this window.
> > > 
> > > Fixes: 55cc1b5937a8 ("migration: create a dedicated connection for rdma return path")
> > > Signed-off-by: Yanfei Xu<yanfei.xu@bytedance.com>
> > This one looks correct to me,
> > 
> > Reviewed-by: Peter Xu<peterx@redhat.com>
> > 
> > Do you have way to reproduce it, or is this theory (or can be reproduced by
> > adding delays)?
> 
> Yes, adding delays can reproduce it.
> 
> For example with sleep(1) and related traces, log at source side:

Thanks for the info, then let's add some of such info into the commit log,
to be clear on how it would trigger (and how likely).

-- 
Peter Xu


