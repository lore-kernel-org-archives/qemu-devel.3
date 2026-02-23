Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCF4E98E06
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuRPf-0007ya-5N; Mon, 23 Feb 2026 03:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vuRPc-0007yA-NY
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vuRPZ-0001vD-KA
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771835723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceGeNNSGKo1PTkpk+4J9sWT/pJvPHE6PrVKzVGMNjhc=;
 b=RPGl9/cdKTuks/xs0dx2iWFh92uEvThtoR30TwNT6FcPNXFgpuG9kZ7MZ2Z3KhGlXIlEdQ
 TKal7NnYrDjXgAB6yfJX18mTXty58lWV1r2zsjgPmRYJyjNQ1RxZuJLhEBECNZjvaYOwzf
 UE0C7THqooDXbuxo8JKjZCfyaZcnVEc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-AulLGjnMMv69nnVN1TKeXA-1; Mon, 23 Feb 2026 03:35:21 -0500
X-MC-Unique: AulLGjnMMv69nnVN1TKeXA-1
X-Mimecast-MFC-AGG-ID: AulLGjnMMv69nnVN1TKeXA_1771835721
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836b7c302fso35294325e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 00:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771835720; cv=none;
 d=google.com; s=arc-20240605;
 b=OmsnJf5QPE4OFzZWhnuPhAMI1ZlrA/zXJT6Qr3DasZ7hoZUA6C3tRlzti4Lmeirasv
 SZw/9Z3dLKGVXCQsMSspxCbuYGMBb/+b1l1g8Ppzx26IOayFq5olDZ6kXqjtDxYqIt5B
 lTrTZ51R0nhxiTO1HPqCDOgjmJYlTtlKsGZ09bYHCVMVmBbSFu+lWJdEHII6sbi43aor
 TbKb+n03NcyHuW0YnB5YmsSwYliDaSOllbkLGHh9Nma/yPdC/5sJaxIgbnUry6ps/N1e
 6WybEaFCQRTqzSOydVzXDdxkCwfIdZY1zMNJn5KvuhtF+0NzJ00SHCEwYrQ+kwmKHa7K
 x7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ceGeNNSGKo1PTkpk+4J9sWT/pJvPHE6PrVKzVGMNjhc=;
 fh=93f3OhIPXpm67EjvkEZsIznV8lOd4WwUuUiNT0IVshE=;
 b=T9Pzp6mRNC2ukAO1ha6McGxQuVcqKuiWoZrye99ZzG5lDtBi4r4sBGHh7Q3AZoVkV/
 49J4kGam/z0yqGfIptjbo9bmEXI/wg11qvtiH2DK7CaIyFbZc/qI5VeQEIR3EMa88HhX
 IOq/BMSOmY4WkF2tYOoXeE97J37huOABmYvcxZ7ivFTvf/Cn7d/HQOfkrHTc99MtQEIP
 Tdpth7kzxT5jlVCpuNkkB48BTuRWtf1QeidUKcEu9qNJTjy6BA3L0XG/Lfsj8a5UPprc
 FWSi2MSOW9HGVrVhFu5vpDG/uV+/Rc+g/3tPb2K96K3wONqtgg0MD1ATEeuGXd0ru2yP
 yHHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771835720; x=1772440520; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ceGeNNSGKo1PTkpk+4J9sWT/pJvPHE6PrVKzVGMNjhc=;
 b=QdPmw65Ta5gi8kSIYyR2u5K7LtJFM/t3bcouWgIFNCedsOOEbDifgZWsvSkZCxFjNi
 l9gQkTdSCRK2tPWufsWndwA4pKnZQrst/uHLJRqYDm/E20vRYzrCIT3a0FhhhLcxJWRF
 CcBepG4ZMyi7pKpJHuYuu7W1N1ApxJaCrrMYPGhmMeOFPmZ66LaO4uHFN9wxDsk16el7
 F6+ItBj5lv20Hpl0DW6D9R5dD71DI2bYDubY/XSMsiV7oaQbdGbwLQtXj8wk2BlZR00T
 CRLXBb45UrBg7FK9lkX+NlYvK/PBExvXx8tlinbA5IFBwn8JZsxjwSGzSMmuHXs8Bk63
 1RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771835720; x=1772440520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ceGeNNSGKo1PTkpk+4J9sWT/pJvPHE6PrVKzVGMNjhc=;
 b=o/64ZtHLGK+lo1Uocc0AtyGL+UjPGQ9Pl5DzGe3XhCIOvJP30kGYaoropmb4fLtA9c
 N2hz89h14DNoSUR+Hx6EXq0ZgezMZ3WBVldHkqdhOvi4OZ5ps9MTwBW3+QkvFiUE+7hp
 HmYhdlaLezgzl5L5VHT1QRnpr8hrX9t5PzlNfIhIQW9bxWJXQwEStzuxo5QP4vwIJVAZ
 jPa6BmlZdHsTdCMVtSOOzX3WEJ+vKsYSVfVNCUXu5ZsFX91fKCQUxmuviAZ0kBpJiA87
 tWwyU1uY+7Mil5ZKSyv7WQkvOzB6sBkkqxGLuwFIszu5fSXipMFJNBmkdt3KjavpUEmS
 hhAw==
X-Gm-Message-State: AOJu0Yxn7DaTIGb+ZOkKr9HTJ9+QhllHALSIKMeT0uJ3X/XDRSk3kNQy
 gCnW13S8NF7ahLu58OsnMhntQ2Fm1uS3JCOBVvxY16x+yATeF0+3ngY59iTpbxr+7vUTH1L5jUs
 2+u188v3o5XgGxpGJ1hDR7WESoPmBGxlAVn89HP73Jma73sTuH6rvxPVUvBCUiSuXKmec8I2QsW
 IdijdqO+IQR1iy0A0eUWFU4ciT4j/KWyQ=
X-Gm-Gg: AZuq6aLFTwd0cGxc2Vf78RyaUaqsOLTU5pv6NJKLP/zS6WKZoDn/JQjEUHAspWtvACR
 s9V3rGkYQIP1dkO/9JEo9vXAjyUwLffc5UShl07nAeyFDNd5TxqvTjAwIk3xhCn51htgXnML172
 MkF4r1YsrZfVB/2sF18OL+96VEmlnMhVo6TvhZRqBxlhJ9PK7tvSaHSL5wNBhNuLLPNNJDK1qPy
 meLliIZ1ekyq3cMsUn7ruFMnTUISaWlJ2sQUigcELqNkN3qT2dJjYN25p1DoxojCUsk
X-Received: by 2002:a05:600c:450c:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-483a963d656mr132164595e9.31.1771835720623; 
 Mon, 23 Feb 2026 00:35:20 -0800 (PST)
X-Received: by 2002:a05:600c:450c:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-483a963d656mr132164215e9.31.1771835720212; Mon, 23 Feb 2026
 00:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20260209132303.717784-1-ppandit@redhat.com>
 <aZd7HDcOa3R2wj8r@x1.local>
In-Reply-To: <aZd7HDcOa3R2wj8r@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 23 Feb 2026 14:05:02 +0530
X-Gm-Features: AaiRm50db3Qy1MptvMsxRj9jhADcrTC991aY4zXX6GsfOneqZXttH-odluYf5oc
Message-ID: <CAE8KmOzs7+pTGYjOc5AA-5rukwOzpEJepmyVCVYSr=bYy+AHpA@mail.gmail.com>
Subject: Re: [PATCH v1] migration: introduce MIGRATION_STATUS_FAILING
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, 
 Prasad Pandit <pjp@fedoraproject.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 20 Feb 2026 at 02:35, Peter Xu <peterx@redhat.com> wrote:
> Thanks for the lists, they all look correct to me.
> I only have one trivial nitpick below,
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -158,7 +158,9 @@
> >  #
> >  # @completed: migration is finished.
> >  #
> > -# @failed: some error occurred during migration process.
> > +# @failing: error occurred during migration, clean-up underway.
>
> Let's add "(since 11.0)" for new status.
>
> If you fix the qapi doc, feel free to add:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

* Okay, will do. Thank you.
---
  - Prasad


