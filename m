Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BAFC25B10
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s53xR-0007sr-Gn; Thu, 09 May 2024 09:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53xP-0007si-TH
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53xO-0003JX-3z
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715261828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8RP4jXw+e/Y50GiZFO1hO2NeXJULrT2cM9EU2hEeJ4=;
 b=eatS0Nnois6/FuK6FulevYgmhfy/rsNC65fepwA0dqGQA5aSSPkfHfwhIke6t0z2N5DUgR
 AxuslCA0aJ4zd541TS0hj7xBrVKO5A6p+c3lpNZBRsvkoKguM3qb6axvYm/+8EGeHrWXZ7
 pId+xL4/wMz16X9+yyDnsoaiIGPzXL8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-fLco9wWtN5inL9jkAaI5kA-1; Thu, 09 May 2024 09:37:07 -0400
X-MC-Unique: fLco9wWtN5inL9jkAaI5kA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a0bd0aee32so682106d6.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 06:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715261827; x=1715866627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8RP4jXw+e/Y50GiZFO1hO2NeXJULrT2cM9EU2hEeJ4=;
 b=LxZuEeCsIhSSAcQWsofxwz1oMkobXf6NQI26ON24FFMJxOh9ytDlWv6hiI5azHmQz3
 tD9gOfYBuA/gTorCzexTChrDv6OSZfSYy9UQ74JkZsk2io4nh/8og1X4Jclu5Kt0eDLA
 gqZHO7kEQxzeWUnY7HSF2K9kr1wOX+rA3mPc3LhB4D1MlzgsVgiwGb7GjRRDAMSfP6PD
 8CTwNyq8UHy0R/tDdRMSfgsZZDyQhjmoBHAmV7m1zYG8BeeUQoDAEkqo09rtkvYoy/wJ
 SBeGegtjDXew6fbn12qN8VuuByliriDjtDYEBXm16yTvxlMBxN7vshVouH7HpfrvZYsk
 ELeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVswdfC/If00ASiQZj53bbf7riPbdXBd1FV2OQrlkaEGsYJTjCUUahF+m6w/JtjPyFam2o7EsoYT37bbcCVcPVuRzl3tlk=
X-Gm-Message-State: AOJu0YwyJe9N/huWVIeAWyzWi78u9/2hXXkcN28KLCA3Ay4mBDTIxSBX
 Jz+05MGxG6x4MRutjaVM2bpIQlFmD3yI598hAzRn1skW5qG6TwHHYEdwwvlASZw5q/i+wEWZ0nr
 /wbqhJnOng5V5DXbvFab7hawjnOvjEIg4ya6KKDdZVowEQOdcV7xS
X-Received: by 2002:a05:620a:190f:b0:792:bcc1:1ef7 with SMTP id
 af79cd13be357-792bcc123b7mr267812685a.7.1715261826646; 
 Thu, 09 May 2024 06:37:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7d+6zhgGWKSWSpxKC4XEC77Dq5Ggicfw9s1QYWqoH5Fo+mRNiN00HkaO9BpduD5qY8dj2pg==
X-Received: by 2002:a05:620a:190f:b0:792:bcc1:1ef7 with SMTP id
 af79cd13be357-792bcc123b7mr267807985a.7.1715261825784; 
 Thu, 09 May 2024 06:37:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf3185efsm67949285a.117.2024.05.09.06.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 06:37:05 -0700 (PDT)
Date: Thu, 9 May 2024 09:37:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-devel@nongnu.org,
 Zhang Chen <chen.zhang@intel.com>
Subject: Re: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
Message-ID: <ZjzRgBd8vUaz9Z7x@x1n>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
 <20240509033106.1321880-2-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240509033106.1321880-2-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Thu, May 09, 2024 at 11:31:05AM +0800, Li Zhijian via wrote:
> Currently, it always returns 0, no need to check the return value at all.
> In addition, enter colo coroutine only if migration_incoming_colo_enabled()
> is true.
> Once the destination side enters the COLO* state, the COLO process will
> take over the remaining processes until COLO exits.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


