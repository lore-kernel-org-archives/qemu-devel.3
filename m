Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541D9EE2095
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voKqw-0000ZY-5I; Fri, 06 Feb 2026 07:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voKqp-0000ZL-Pg
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:22:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voKqn-0003KL-W4
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770380537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e1svD55HlqZwmBm6kjXpGUs7F218F09mpvn+mUdQycY=;
 b=hPnDHrehXjxmOFozHNMRfaQwqUFbc/4BCdjFonRy7D55x9tg4MktHuLNE+MfITghJyjAgc
 9pm2TYxCjTS9AiD8akgigJFwbs7GCTs8MbVPKCdUL8FDx+P7phUvCZR+dBSl6/sKAmYXAQ
 m3DjqHV61MAq5fzQl8gADj42fOMvOHo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-lqTxFFKVMqCE8xHWwWnM8w-1; Fri, 06 Feb 2026 07:22:13 -0500
X-MC-Unique: lqTxFFKVMqCE8xHWwWnM8w-1
X-Mimecast-MFC-AGG-ID: lqTxFFKVMqCE8xHWwWnM8w_1770380532
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso23589105e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 04:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770380532; x=1770985332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=e1svD55HlqZwmBm6kjXpGUs7F218F09mpvn+mUdQycY=;
 b=rjo6POjG/WZfYVHcbeNareqT4cfTqYk+tEsEBuMTWTWDyTJUpE11rOQoSvICKHCMhv
 PLqAdpX1vNuTpQbNMS2eUtqI8A4GqIr56WPdVR7Ow2qS6KwGYkER/9JyIhMGH78sn4aF
 6xL5W39ueBy+oGb24MCeNOc+AzT4QhsRR8Bvu9EhpZHRJcXFXtnNdHCMRGY+cbYieqFN
 UGRFZ2da/wcZFBjjs5lX+jEq3F3DeHagun58fKwsJ5l3L2SwyLk5S3C7YlNv+rN4MfjF
 m2DzwR0SEhHfj0MOYtrctQ+7At5IYoiYU6UhqeyDRoEk6eQnswkT16BuklzBKBLcdu5a
 lc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770380532; x=1770985332;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1svD55HlqZwmBm6kjXpGUs7F218F09mpvn+mUdQycY=;
 b=Ez4lrj/XRtcdSsZthQuYz3HIS76PHBSQsLmI0VMvgznHOowfuCDrvp1/NKQpiSofA5
 UEsoH7tCYt5fz1V5938w1wtqj4w/zponAAxQDeQxwBePv1errPBMWN9rs8EuKluJ2vWq
 ABmFwhJbXZ9lkxUYiojBfl4oAkpI0HI5Ov4DNeAEzSoKfEudVVfeQBG+xlDPPippTXs8
 Q3dz0tpbtwyPzOZe8xEDHMy5Bh2OCacm3LFU/wJudhEckd3BLROopgKlGRCsdRdwnhXZ
 oT+YP8kJQpfRzEDpzLbTIkg5GMs+yNKHtMHQrUgKw+ByqqF45f1Y6Fd6HYOBXtnp4yAq
 Yidg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTNrUFqruMI34G44C+KWnOhVstTuBUru5tRHHtUnGol1Kvuna7Wwck07YYfTpRRp57kB9oEeXb6e44@nongnu.org
X-Gm-Message-State: AOJu0YxhajFCzzukdQM8Z58kKlLEaX0iE52ZqhLYEFY/xpWxupnb560P
 soYSxKbJ4kur7cJh284dXqyBjYKnodYros6djm63JCmjSFp3tC7x/v73GEwXExmz34SzWtNORh+
 sY0XEilmjpRWi37CsFDSxYz8qEu0XwR7Pa7yySCiOs0FihWhnL9Y54ZFX
X-Gm-Gg: AZuq6aI4T2WA2RjWgycUpAbxjfHfy8ZuPpzFzeTVDRdTyLj7Z59EDd59fWzdI9xzzlT
 zTnP4eH+jZ6IEkTqepDLo7eWhuEsf5FszYIONrq6L4lKRUEen6ETwDONuzZP3QNlCV2pZTT5+dF
 FoSmd5l3/b0DOJFRp7zoR5GTwm1N3zvxd/kQ5O2d2GdMzERePU3OgA6Na87Jxd6+ng7zsYfK+WJ
 G2Op42nN35UuAJCeXQ8s9ktey9bzrq5SNzIJnhlvfmnY3kJQknUfKu3zcsNireCot8FIJR7cfqT
 Bfo1IJWNBPjaefpD6PckqD6A6ZzbqIocpJbvhg33sLEdE9gmOAXefBM/dA3gLX/oRUHoXloxu4u
 4KCNLUT8=
X-Received: by 2002:a05:600c:35d1:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-4832021b572mr33862965e9.19.1770380532082; 
 Fri, 06 Feb 2026 04:22:12 -0800 (PST)
X-Received: by 2002:a05:600c:35d1:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-4832021b572mr33862715e9.19.1770380531673; 
 Fri, 06 Feb 2026 04:22:11 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d7a963sm108188985e9.9.2026.02.06.04.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 04:22:11 -0800 (PST)
Message-ID: <1a58d2cd-39bb-41af-ac87-dd83d445d166@redhat.com>
Date: Fri, 6 Feb 2026 13:22:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/functional/migration: Add migrate_vms
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-3-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260204172332.21367-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/02/2026 18.23, Fabiano Rosas wrote:
> Add a migration helper to MigrationTest that uses the migrate-incoming
> QMP commmand and takes the already instantiated VMs. The -incoming
> 'defer' command line option is preferred way instead of the -incoming
> URI syntax that's currently used.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/functional/migration.py | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> index 0aa873edba..3362e5c743 100644
> --- a/tests/functional/migration.py
> +++ b/tests/functional/migration.py
> @@ -40,6 +40,11 @@ def assert_migration(self, src_vm, dst_vm):
>           self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
>           self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
>   
> +    def migrate_vms(self, dst_uri, src_uri, dst_vm, src_vm):
> +        dst_vm.qmp('migrate-incoming', uri=dst_uri)
> +        src_vm.qmp('migrate', uri=src_uri)
> +        self.assert_migration(src_vm, dst_vm)

Reviewed-by: Thomas Huth <thuth@redhat.com>


