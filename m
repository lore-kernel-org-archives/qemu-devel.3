Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DB9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1X3K-0006fn-6F; Mon, 29 Apr 2024 15:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1X3I-0006fG-7L
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1X3G-0003aI-If
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714420357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x2wqT5+KTHMPEQl8bWURFMbICMWM8AZmbI554xK+xn8=;
 b=OkDb03Je9p/ctlo1Watgb0G7XaJP2AqtAQAdLhk6+qgBV/lKHm316IwCEj+0m/WhIaimq4
 8nvyw0ETcOw+dfJFH3P3fvitCFnMOgTaqhuKvKSN5PjbJOnTso58T84FDcLyoDAqGsZW+9
 fTTbgKW1UX2/xeFyR8eBWOit3haG/5A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-zg526goEOL6eZcn61MQQjw-1; Mon, 29 Apr 2024 15:52:35 -0400
X-MC-Unique: zg526goEOL6eZcn61MQQjw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ab48d14388so1577362a91.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714420354; x=1715025154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2wqT5+KTHMPEQl8bWURFMbICMWM8AZmbI554xK+xn8=;
 b=a+LGV6xrII0F/MtGI3DrFJC3NH2GbX9OhR443MvVCLV864U45WD9yBB0/6V4dYqwTB
 Kbzh0vY9ujqXmraCDcQ3lRFeUBcLXntk4sjaFoBVZuwNhz5xMlncyD6jhWCnkMcu7yhZ
 k9lSKB3dZxjjkbKseg1O6nJgBOAUXDaUvjBxPa3tQwvegZUag0OkJnfoOt3hM8m+7Qcn
 AltrygO5sgQa4590UfTU8PGuZRe2rFwDOeXOSCD7fYCD9P+DsgFSqbll0yH0iqN7Uvs0
 1niPZqfSq19C/iKsihuJs5SMZxMogj99tklc2M1OSh3nbiYY5W6Chj7GWMWEDj5Ej8BS
 4kZg==
X-Gm-Message-State: AOJu0YyIl/iGlg8s3orxbofKmBxrzytaa19Yx2VxqPE3z74JUzooAKL4
 oxEL5dlYQKnHCYeEgm5djSMFXRsfmH5VvirYqeT0DfQYNrn8MXWT0PNAjxKuA1Ioqr4qtZH5TDG
 jiBAJNkY5bH3oOJ4fsKj2mK8BezOJXqcEIwqp7QmMG9cmCcA0fPpn
X-Received: by 2002:a17:903:234b:b0:1e2:c544:9bb0 with SMTP id
 c11-20020a170903234b00b001e2c5449bb0mr13549149plh.0.1714420354319; 
 Mon, 29 Apr 2024 12:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8fSPnIA3kgGj7MYXa/OgxZYrT3Ax62/Bt1mDPJvSSs6u8TvXVdIGr35TufrEo2fUq4PMj4g==
X-Received: by 2002:a17:903:234b:b0:1e2:c544:9bb0 with SMTP id
 c11-20020a170903234b00b001e2c5449bb0mr13549126plh.0.1714420353827; 
 Mon, 29 Apr 2024 12:52:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 w17-20020a170902d11100b001e42f215f33sm20794154plw.85.2024.04.29.12.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:52:33 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:52:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/6] migration: Remove non-multifd compression
Message-ID: <Zi_6fR2bGDZmnyFV@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426131408.25410-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 26, 2024 at 10:14:07AM -0300, Fabiano Rosas wrote:
> The 'compress' migration capability enables the old compression code
> which has shown issues over the years and is thought to be less stable
> and tested than the more recent multifd-based compression. The old
> compression code has been deprecated in 8.2 and now is time to remove
> it.
> 
> Deprecation commit 864128df46 ("migration: Deprecate old compression
> method").
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


