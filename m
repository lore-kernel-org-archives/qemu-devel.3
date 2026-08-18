Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F5BC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPFA-0003cH-Lm; Tue, 18 Aug 2026 15:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwPF8-0003bX-Qc
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwPF7-0004vK-7H
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787080380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SlXFld1p0JMuOreX0+mVfLzrL5jgBYTouIZTfdSh1sM=;
 b=E4zVjLrYy/6fohp6flORUffL79DdC4B73y4M/c35GyQ1KjPbb0D+i9OOplOtSLmphr+Qof
 wpOP0hyIqySvOWTllF4M4rWVwFjACD9uoVtsIzI5ZsZ3mBsFcDfHKeMmL3stHOqy+YhGze
 EoJpJHKaqj8AF0/Grw6kdzLogfvz3Gc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-NlyHuJd4PqSilOwlfh-lCg-1; Tue, 18 Aug 2026 15:12:58 -0400
X-MC-Unique: NlyHuJd4PqSilOwlfh-lCg-1
X-Mimecast-MFC-AGG-ID: NlyHuJd4PqSilOwlfh-lCg_1787080378
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934979ee9f1so31484985a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787080378; x=1787685178; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SlXFld1p0JMuOreX0+mVfLzrL5jgBYTouIZTfdSh1sM=;
 b=JRXbc7M50bKJhj1ef+ZHiUcJ3gWrUHDLfjR+yqAkd34aTzTNgu/tqacVgJ5gTL71FB
 oteNxaL6fZNfDxdnLHFn+PLxtNcdDPaMImXJwN+4yGwAE3aG6Tk9UUlp+jlPh+53hG5G
 AOY9/2x4XvltcGpVEYFXDlRoBNMb0YbG4fvPWylJ+brg4zpqgeQO4ho1OWtgdmZb+VIQ
 SEEUU5hLqIp9X/EqzfF6EZa63Dv0padOmpBVsJBg1jXZizl9dQWU3mWHlF3nuHoRx/P3
 rhbwn/aiK9ggPv0vG16HolCv1RaiH75cPQ1FgPXjG/pgB1n4zOuvnJ5V+aAIre9itqVR
 vPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787080378; x=1787685178;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SlXFld1p0JMuOreX0+mVfLzrL5jgBYTouIZTfdSh1sM=;
 b=agsVPybtM8kurtslLasjSedPccjW3vjnBfECG6pupbi4ANBAgwQPdic7HYNxHTuFmz
 HqbTHNKjYJOCRovaLrvopYKDLpqjvFB26B3KfEZ9VBwER7nSiiu/F/fl8ysvXIPbMH9Y
 QJVww7fYhOcTCMFxSR+HQKsBK0kCI7xAxsTDneZ48VEVucPjcwD7nKudTz36cj8E8UjQ
 SpqKMAT/KRP032uqNrDgfMEDBHhuYEA39RP0kUJjX8oLZMa2zc1b7061n0v9TIM0xrk5
 y+ICL5AP6sie637O7wbQ3aCP69cbi/YOj4rqKBTheMe+5Ys+E6+uoJ0qC/JXE9PieczL
 x68A==
X-Gm-Message-State: AOJu0YxFTsEiRUtNe7/IVizuMS+ciZ6+PZ62kcE2YHcIWRaA8sQdJXow
 833mrNt9v0WXivgJDEu8tQSuCy+C4U9VVTZqZl6P67Hu6SbQjLSJAbk/VGbF0zqm4bP5IxHm7v2
 uXXmIDWAZvWaOGXH0aW5LBGVvh1jiDw9r2APP7xMhb9u5LFcfkx/vsnAl
X-Gm-Gg: AR+sD12ybSRtLgY0aq0Wt3b4IgwqchnFCtU+t/7zV7r55/Ts6zgRA4E5y+LSsa/iGjd
 0aYTdm1oAP2ZaDUN7YNx3OK6xUb2CyGtAr8sbjCxz0MP53/VjlpOxDqyu9Zt0RCgf3M+E0rBz3M
 lDMnNsYi9tCB3zJAy0MLtBfCPzrh+voGGOXPVLywhMDwhb1wMHjfAWIcdV2iTDsdL6bPQDPy8eK
 h+21FXiea4zmFgH/+u2okJTP+We6eLti/E4eRnUoyfoLOjNeGhjRouTKusIlvkxfjDvhDFtKBxb
 LWcHXdy7c7UvXvzNv/JnZOjTf8uqKQRKeb8YAHxm/SoofRfnFGri7cnvBC8XQRIEk9JzdHjHI46
 yhoa0JVXWMHHLT43TzkTNsGLsOn6r/BwiJHT41Cg7thkuLLWSKzv1h/rjqbg=
X-Received: by 2002:a05:620a:601b:b0:930:b19a:9d5e with SMTP id
 af79cd13be357-936d1fd9f8bmr3944368685a.1.1787080378003; 
 Tue, 18 Aug 2026 12:12:58 -0700 (PDT)
X-Received: by 2002:a05:620a:601b:b0:930:b19a:9d5e with SMTP id
 af79cd13be357-936d1fd9f8bmr3944360585a.1.1787080377436; 
 Tue, 18 Aug 2026 12:12:57 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937010e801asm399578285a.18.2026.08.18.12.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:12:56 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:12:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Seungjung Kim <seungjung0711@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 2/8] migration: Introduce VMStateStructMember
Message-ID: <aoSut_FMo_ShRH9t@x1.local>
References: <20260818182441.404790-1-farosas@suse.de>
 <20260818182441.404790-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818182441.404790-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

On Tue, Aug 18, 2026 at 03:24:35PM -0300, Fabiano Rosas wrote:
>      /*
> -     * @size or @size_offset specifies the size of the element embeded in
> -     * the field.  Only one of them should be present never both.  When
> -     * @size_offset is used together with VMS_VBUFFER, it means the size is
> -     * dynamic calculated instead of a constant.
> +     * @size directly specifies the size of the element being
> +     * migrated.
>       *
> -     * When the field is an array of any type, this stores the size of one
> -     * element of the array.
> +     * @size_indirect specifies the offset inside a struct where the
> +     * size of the element is stored.
>       *
> -     * NOTE: even if VMS_POINTER or VMS_ARRAY_OF_POINTER may be specified,
> -     * this parameter always reflects the real size of the objects that a
> -     * pointer point to.
> +     *   Only one of the above should be present (except for
> +     *   VMSTATE_MULTIPLY which uses .size as a multiplier). When

VMS_MULTIPLY

> +     *   @size_indirect is used together with VMS_VBUFFER, it means
> +     *   the size is dynamic calculated instead of a constant.
> +     *
> +     *   When the field is an array of any type, these refer to the size
> +     *   of one element of the array.
> +     *
> +     *   NOTE: even if VMS_POINTER or VMS_ARRAY_OF_POINTER may be
> +     *   specified, these parameters always reflect the real size of the
> +     *   objects that a pointer point to.
> +     *
> +     * @num_indirect specifies the offset inside a struct where the
> +     * number of elements of an array is stored.
>       */

-- 
Peter Xu


