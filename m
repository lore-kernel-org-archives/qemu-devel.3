Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83227C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAl7i-0005el-3F; Sun, 27 Sep 2026 05:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xAl7e-0005eX-RD
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xAl7c-0001B5-Tp
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790501076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o19ZJnCEkLBIgRR9lWtaAd2OmEGl7ZZi6CDt0uItaVs=;
 b=TQLM5mO8xNlLdUCWOFyn/dQvtP9hf7gzgXc64HIYzsuXrRVFXrs2gOHJt9YnEPL75dgAu4
 6LAvRUpfWjd+u/FUTJ3Do35WETG2GY2i7QsUiM3wlfjONsAbF1bUMA2aGLKpoW4HfPpVVs
 N5ZKPv2y6C/Hz0tETvIlIaahDwKKwVc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-cJBOFNPqOWSiZouUQbjyOw-1; Sun, 27 Sep 2026 05:24:32 -0400
X-MC-Unique: cJBOFNPqOWSiZouUQbjyOw-1
X-Mimecast-MFC-AGG-ID: cJBOFNPqOWSiZouUQbjyOw_1790501071
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49ccfad90f1so16907795e9.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790501071; x=1791105871; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o19ZJnCEkLBIgRR9lWtaAd2OmEGl7ZZi6CDt0uItaVs=;
 b=GHKT6cupd8O4N0S/n2dkZ2Yd3Xo2UnM0mQkxAjUIERGCCY5xkOl8mregkBQ6foJe3u
 VG8q+KUzyMYyagZcICWHuvBLvpHUHHad7EEmw+cqmS2PvbxMR7rFY0ba3+i85exaeVDH
 dzbCQD7HUm/gTjRMoGs5Iek5tCdyvzv6GfneNaHn0GktIClCiHzG/UKT69ZXNUOT+MOQ
 UXPSDX+uSqQnETyNWcPB5rlGKkukjf6bhjWbdKEH/0SoQ46Tvk2RAcmoXNqgRPbHvadX
 scrmduoQl7VTlMDJr/+Tu8GsLS//yWfFjLpncRn8FXkr79TTd8kISjBCeuGH/MHwfcO7
 vjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790501071; x=1791105871;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o19ZJnCEkLBIgRR9lWtaAd2OmEGl7ZZi6CDt0uItaVs=;
 b=RpYOBrEgcySpVCJR9btR74kJGBG2pKS9R1O+MaucalPX8ef7mAN3FFwLa3wGtQcNPP
 qbKwfcjcNbnC87OU8UcyEusy/4PeC1XGQk9LvZ4PrJ7E1xBUwJOYH0sIsTV4ZH+nymzN
 pYYfBl5FPSkEC/doG6FyVTuKAH1aplVRjJRpyLhz8z+TDIGU1Bi5NBONisEEKsAd4/Ll
 GkYKDGNoMpR7xodkbnPgZpwTzz2WuatltqW4g8A6nkCMvmJX41UGXEzjPnOZl3OzQC1H
 CXWVvSW0b6Ahmp4iBzmcl+Vy9UnWt92ylz/AVfCRnKkmD2xGXbBmmBNBXg50HGKb03Q5
 jlrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLHEEKn6ZVx96FwlnB5hRRjVBWNhajbcPNV+YhFrB4FJxDjqdpUonq7uZeXXYNu9sOkNhsVqjpwGCq@nongnu.org
X-Gm-Message-State: AFuF++nwYAjJ60Je3C5HMq8YatQhlZYhlIcEpiDo606ZPnFA2gIdTbWL
 hMWp26isaPtzP3VvVioe5CGOBSWCZxXSDa9sfpx2PvrHxi5VCHicMPJILTpaSaI+qBSOi0EBIdJ
 qsF+SjuhGeWKC3bNMjRW/2cZBB3QkOCEcCcRedwTmoMl559ZJONt6QprG
X-Gm-Gg: AYBFou3fKregYqAMV4YZe68XCgfCCzcBWt4SpG/jqeSUHTp64tYmbK7g/5iOHc1Xo9P
 wD6sY8vaxShsUURQsbs2G/IT4rgjIzeOYqa2Ji71zcvRYLiXpzxJHKGlsIj3c7P+/TnpF/dXAx1
 3H3ePeS1ShwDBg0tm2X8iG4T9xWIOPsmxpJJxuYDl2pXWbB874CD+PZHRawB8IMgfCodysNA3Xc
 PQwr0jnI05ho9kizwRGso2o2yCT4AygLSV7vzUmjnLzoqDRq7AsxDChOiOMZ1ahGyLw2KZ4mXq6
 LRHAOG6cN0NApkO/SEPnRYjyuKgNb4Jy1qqBtfD0EHqyB+8fnbcqSNd5uYd6jw4SE7k7bKiscAR
 BJNgRxI3OmLwa9uNI+PKw2+VnZ1N6KBTzlFOXb1tQ3U6LdLfdHXUGQ9DNt4PvHvIhXA==
X-Received: by 2002:a05:600c:a15:b0:49e:7c7e:274c with SMTP id
 5b1f17b1804b1-49ff06bdedamr113949375e9.14.1790501070925; 
 Sun, 27 Sep 2026 02:24:30 -0700 (PDT)
X-Received: by 2002:a05:600c:a15:b0:49e:7c7e:274c with SMTP id
 5b1f17b1804b1-49ff06bdedamr113949165e9.14.1790501070522; 
 Sun, 27 Sep 2026 02:24:30 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0019162fcsm44837945e9.13.2026.09.27.02.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:24:29 -0700 (PDT)
Date: Sun, 27 Sep 2026 05:24:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260927052335-mutt-send-email-mst@kernel.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <arEvLLYK9A5MKNdE@redhat.com> <arP7TDfz7lz699KJ@redhat.com>
 <87ik3vyp3i.fsf@draig.linaro.org> <arT_kefzEhqg8-FB@redhat.com>
 <arUJxE0F7Q3Cw5sk@redhat.com> <arZHWKAgr-GYvoeX@redhat.com>
 <arZZhpR5_nPybOUo@redhat.com>
 <e030a85d-a5d5-8fc6-5d1a-41167f7a95bf@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e030a85d-a5d5-8fc6-5d1a-41167f7a95bf@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, Sep 25, 2026 at 02:20:49PM +0200, BALATON Zoltan wrote:
> Not directly related to this patch but as an input to this discussion I'd
> like to bring to your attention how some people use AI now. With LLMs being
> able to do more, some users who have no idea about coding or QEMU internals
> but want to use QEMU for things that we could not deliver, now just maintain
> a fork and let the AI add features and fix bugs they find without ever
> contacting us or reporting these back.

More power to them I say. There's no way to find gold in this sand. Let
them be.

-- 
MST


