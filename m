Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E415D1118E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 19:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOL5i-0001Uf-Vq; Wed, 26 Nov 2025 14:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOL5Z-0001SN-Ed
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 14:22:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vOL5W-0001Xw-6J
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 14:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764184919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=62jLugxOBEqOCxod8mKazbkXd6w8JeNGtCbG2f8rsxc=;
 b=F0yW/bbuHm25uWKdTZrexwz3CYOw7MR3GoAt/vewPXVmsroyiQvdFdFrrBBsMVr6FfqCKx
 HJvbFQ97j5oS2+idA7DtWTiLP4jqBZX5j7nwguBVQx5oOKKUia8OhMZ08BjDs71blcNQJC
 lgHdHXNdlDMdK3DutGQeGFQi5KIw0rc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-OTPuINjoO0qNe9qyZRLMZQ-1; Wed, 26 Nov 2025 14:21:56 -0500
X-MC-Unique: OTPuINjoO0qNe9qyZRLMZQ-1
X-Mimecast-MFC-AGG-ID: OTPuINjoO0qNe9qyZRLMZQ_1764184916
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ed6ceab125so3665811cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764184915; x=1764789715; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=62jLugxOBEqOCxod8mKazbkXd6w8JeNGtCbG2f8rsxc=;
 b=t8BMYXqffHmLUveYaF8At/t9RxhxRiUUEYciBdbs/l+Y0xGOikJBAwZmddrQm8/D3b
 Na50dvOSe6Wb8nkSkyPxByIiMeHbmSD159YReczWuciBIV3kk/eofJ+pIR1xO4qlqDwz
 y2SQDqMo4UXXXD1UVYba99JpVd7Cs6/S3KRsm9XdR+mVSfM11dGT4B0uFa8wEUDftY/h
 3vqQ0YHYbg1nQWN99ZcvMKg3JoQFDHhjU4hZVvuB7DQiSlL4gYfWLqKR/ZW9SIzAFIaL
 6INzeb06n0v76CRS6wwnywwhkkB7epamrCcW5CeYVjBFZCTr2TuAVu5Hz81RUvX1uJ0J
 y8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764184915; x=1764789715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62jLugxOBEqOCxod8mKazbkXd6w8JeNGtCbG2f8rsxc=;
 b=at1ZcCK5cvfPDJzhbSehlG3ZhTjSwECrtozaeKg0jRaWHo2eENv3Rrh8GHg5+pLEpm
 muPfEPw68NmdsH7o2i/gXxFDoeKgCulB/k+9pcsccDKi0QevXpxRbgKqOwCYW+c1VO2D
 Gm5zfaqq5Z6B61Zyp0N623sSLyzCL87zkHDNlAh6VmjGEtmK2artxlYZEM34u+SRAlUh
 T6YSyITeWlhg6HUX+JJG+QDXSEG8yn39Da8uhFZvxXhLetaqT91Wrm0sXpZydq9gHtp7
 Tvnqk69T68H9HBDBF9QuzLi5YnHyDihnFeQVrk43ibCmMokcz4COeCyXcXjRpmc7i5Ex
 rFuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMkGj1jVzpJQt7RuJiO2t4QUeR2i1Q/tgt2lywUIrZQp9R7Tl/0XW5bm40VbPdsPvew2iYwvnlZtvG@nongnu.org
X-Gm-Message-State: AOJu0YzTAhYGTUTu73SaqZDEKyatoTt839QFIFrx+VHzqUUg2c4p5MMq
 /hMCsYllP/ECWS5unk8iHpzH6HHsrmuPd+O+va+4dOOKHO6uzHnSw2FNlGz6szz6zq+6M/sbgbU
 oZNNsK8sIERUegpZMfeKmbt8KllvLckkdTxPoBxKHYmtXGI3Uwr3SfYUn
X-Gm-Gg: ASbGnctos4aL9yRnExl3pZ7PryUe+tc+sk/6yFtRytQUL8V+Ckr+fSSDwDWWQAV9m7S
 S85hB132AZzjeApCbKTwel+qBKLJpzzsF+d2W2EhA03Q3+ttnDnhkfe6oN+EsBl8qFsBZV8KpVk
 fBpWthbb6noX08dHmIiv53DpQBN5q5GzQV0E1MF70goWYY62shbn0HL4ozOHJJsvfEgaz6gGDY1
 vYUh4goTEOVQvVAb5KDQEGNYhKgObcPIy/8EeFYVjV7A6C9emfhRKIrTifrVCNtwt5jz6U0xTc4
 aPLi7LuFPiDZiSHDLA7SYxS1jVg0DYsbaFzVVxG2QRHalCSqpOoqqkC4ILhmj0VzTqb6avWvQGb
 6Ui0=
X-Received: by 2002:ac8:7f94:0:b0:4ee:1c98:7933 with SMTP id
 d75a77b69052e-4ee58801da3mr281434811cf.13.1764184915585; 
 Wed, 26 Nov 2025 11:21:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmqQjGp5olQlHg2qFBUb6zHgQaahNSElIhEKu4v0El3V0BmguGzzJo1OaxAQmv877vTDlMqg==
X-Received: by 2002:ac8:7f94:0:b0:4ee:1c98:7933 with SMTP id
 d75a77b69052e-4ee58801da3mr281434431cf.13.1764184915064; 
 Wed, 26 Nov 2025 11:21:55 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efbd411763sm39725141cf.17.2025.11.26.11.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 11:21:54 -0800 (PST)
Date: Wed, 26 Nov 2025 14:21:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Pawel Zmarzly <pzmarzly0@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: fix parsing snapshots with x-ignore-shared
 flag
Message-ID: <aSdTUUbTbrTRQ3Ji@x1.local>
References: <20251126121233.542473-1-pzmarzly0@gmail.com>
 <87ldjtdk9t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldjtdk9t.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 26, 2025 at 09:57:02AM -0300, Fabiano Rosas wrote:
> Pawel Zmarzly <pzmarzly0@gmail.com> writes:
> 
> > Snapshots made with mapped-ram and x-ignore-shared flags are
> > not parsed properly.
> >
> 
> I'd suggest some extra words to help people in the future (no need to
> resend, we can add it while merging):
> 
> "The ignore-shared feature adds and extra field in the stream, which
> needs to be consumed on the destination side. Even though mapped-ram has
> a fixed header format, the ignore-shared is part of the "generic" stream
> infomation so the mapped-ram code is currently skipping that be64 read
> which incorrectly offsets every subsequent read from the stream.
> 
> The current ignore-shared handling can simply be moved earlier in the
> code to encompass mapped-ram as well since the ignore-shared doubleword
> is the first one read when parsing the ramblock section of the stream."
> 
> > Co-authored-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
> 
> taking or leaving my additions:
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 
> @Peter, we can probably merge this and deal with the rest of the
> ignore-shared situation later, right?

Yes agreed.

I queued this patch for -rc3 with Fabiano's update on the commit log,
thanks!

-- 
Peter Xu


