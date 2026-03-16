Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488A4F53D91
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 19:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ddo-0000en-Ui; Mon, 16 Mar 2026 15:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2Ddn-0000eX-9j
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 15:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w2Ddk-0004sJ-CF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 15:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773689410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ucl4ERDdJi180VcAjKMWTJ0PvkPjwBZSpzVsQQqJKew=;
 b=cl1CgNPIEgxGZxoWHyfyqdIVYgGIhYm27FLVMf59UP0F28tkN7qBLKjmOJTQqa7uGOe3LP
 S7VCbffQzQoOXOT1Cc9MjS0p/NSAUu2fqKlMyLoJov7+8NH5dhpQ8eT9cwb2rz9CE5mK4U
 yYPdZVR3qn8AwqZ1l96NAEIYjmZvnG4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-8XWsGzb9PUK8w4ut9TaHzA-1; Mon, 16 Mar 2026 15:30:08 -0400
X-MC-Unique: 8XWsGzb9PUK8w4ut9TaHzA-1
X-Mimecast-MFC-AGG-ID: 8XWsGzb9PUK8w4ut9TaHzA_1773689408
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb52a9c0eeso5170263185a.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773689408; x=1774294208; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ucl4ERDdJi180VcAjKMWTJ0PvkPjwBZSpzVsQQqJKew=;
 b=SwGlrnWXMlFPXjlHUVw+rbQ3JFi1XoRIcFMf5TiqwbR1+h1bKu6fbfueiG0inf1TZh
 RjBbkej+l3j2OVATmqBR+fHIBcbfV7mBt8Gxfj8bHyVorR97aGm2RtqKt8+vQEWBThIG
 7KL/1svE3aiE2MyWNhv9qIWvaZlq0uwZFeGisG1GZp8U7l5zhv2BzoZbzh0bJxtdPHN6
 ltVTCTTqfWwQ3kmi2Hwd77D1dCoQRJjJE1Gys1CJruDCl2a5ouFpUC5WabNjeMLQkwvv
 tRo/Sfj4trqrn5PKADqt1aaCvwqykcfDNwuWdINBuOSgYgawBzk8bEaY83/kRwNegEXy
 1ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773689408; x=1774294208;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ucl4ERDdJi180VcAjKMWTJ0PvkPjwBZSpzVsQQqJKew=;
 b=ZjeXj1egAk8d+Bi33JBj1hOS+c9IsYGHmg1pyilk0DUym3ssd+uc+vIu/BblA7nBOP
 3ZD/DnYyUj5JyWKtybbGKJ7QTRO9BrWbSZbnvsdQrd66p4pof5RHsFaaxRGt4wOgeAyv
 6WKENwAeju0Ki7p9pK0R1Ue4/PaUjR1QYfNfY5kyuLJm9l8m8ACk2r/3W2d2LaGzaIw/
 oGxb/9RzLaHyIU2XBQVf2cQLedcjB6K0dvPAzp4/9oGNC8xwGRjx4fZgApesm7iv1Rfv
 V5lSkK5hqD2GBRxdjDlxSjVwpXWUOep+87AJek1XKesf6ibDcsuXJwhwjdykn6dwNyUt
 i28Q==
X-Gm-Message-State: AOJu0YyHf+VLfcsX+l+D71s8WOAZMxr4HJ/vIYyGIX+c2TRIbsCuBvyR
 PAXg3ROJZ+VOnGL93F+Rjg3ZOzmHVmZsmrHgxV4SX7j1ZMXfLipnNVKsSRgZ1sUHoN5AY7IjyBF
 MdNwKi3xA3Zp+Cq9G3C4yCiKE70YH4FC5DFN0E+wXgKFFHcxySIwfIlo3
X-Gm-Gg: ATEYQzxmp38vXO7oJu+ftLDpw8btWBQvXa4ynSr4Ce4TesoEgfLeFqo8WVp2HGU6DCA
 83MzZwMXEHmazcsBlI5GNrgQ7q93m3nbTzmznqVFb2w1GE86X8m7Jj7sV10B327O667KKVJkz0D
 qEzKs1bHUr6isu6fI57Synm0boDR2TGcA6s/XEv/kfwJwMVuFsF8JDsyS8Mfjc2/NurQd5RQVx0
 ggIUa+pMTO1x5sGYzHjjuXOF+Li+usvSQOxZofRtHh2661ArVXblLQuC5WLb0x2blR2Zpy7gU7P
 v4Vv6+YvKCr6mIhPN25tQTLO5WaWW9MFW2m18I2IP5f+OhT4+4Rxo0cwnG86vNYOMngCv2vnC9V
 G9fWpFbYPwmmj0g==
X-Received: by 2002:a05:620a:1724:b0:8cd:8e7a:980 with SMTP id
 af79cd13be357-8cdb5b5f2e4mr1759958685a.40.1773689407990; 
 Mon, 16 Mar 2026 12:30:07 -0700 (PDT)
X-Received: by 2002:a05:620a:1724:b0:8cd:8e7a:980 with SMTP id
 af79cd13be357-8cdb5b5f2e4mr1759948585a.40.1773689407215; 
 Mon, 16 Mar 2026 12:30:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cddee16b15sm105054485a.20.2026.03.16.12.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 12:30:06 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:30:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH] tests: Replace ncat with socat in migration test and
 drop ncat from containers
Message-ID: <abhaPbLFHo5Dodxm@x1.local>
References: <20260316183016.239526-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260316183016.239526-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Mon, Mar 16, 2026 at 07:30:16PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> nmap / ncat has a somewhat problematic license (e.g. saying claiming
> that derived work is also considered for software that "is designed
> specifically to execute Covered Software and parse the results", e.g.
> by executing ncat from your own program, you might already fall into
> this category) - so for example in openSUSE 16, you can only find it
> in the "non-OSS" repository.
> 
> We are currently only using it in the migration functional test, and
> that likely does not fall into this "derived work" category yet (since
> it is also doing some other stuff), but still, to be safe, we should
> move away from using it now.
> 
> Unfortunately, switching to one of the other flavors of netcat is
> also not a real option (see commit f700abbbeb6ab68a3446d1fb168a934d),
> but socat should be a solid replacement here instead.
> 
> To avoid that someone else easily uses ncat again, let's also remove
> it from our container files now.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


