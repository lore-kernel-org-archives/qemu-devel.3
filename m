Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98884C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRbP-0004LC-Vb; Wed, 26 Mar 2025 10:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txRaf-00041T-MW
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txRaX-0005YY-To
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742998716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9lPXiMEOx1SEK0P84TOPNSoVbjQM8OyYLm8AVX1StU=;
 b=cyKZ1SDZwTN8I7KAlIanifQJWl7fO9qns1olRmKB406C5C21GwrookyzHnvhxAdl6B8WBf
 lQkjkQdGRb3QrfjLB/4+AWssEZrnKIoep/TqhrHa6f7IU67b8wzfG7ISlWX9KPS/FS8r3Y
 l38alO23tvfVSiHH2a4rbtEAQ2eBISM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-py4B0F06PymsC8LEdaYoCw-1; Wed, 26 Mar 2025 10:18:34 -0400
X-MC-Unique: py4B0F06PymsC8LEdaYoCw-1
X-Mimecast-MFC-AGG-ID: py4B0F06PymsC8LEdaYoCw_1742998714
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so41750135e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 07:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742998713; x=1743603513;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o9lPXiMEOx1SEK0P84TOPNSoVbjQM8OyYLm8AVX1StU=;
 b=a4Qf5HyV5xf5X49ukXfZFQ1rFL7y4hvKPG5H7WGk42fxFurDicnES+NQhjYPSgoJ7/
 lUtYmQoFQtJ8FFZ3VBeO2KlGWsnBc+HSUFZioIPID3ZxJs5NJ4ZoBTQM1f4btS/Qgt7R
 y5Cccy9Rvq4l3i6kwJ9HV6DBVcb6VM2ZAlEzHv6u9qZYkVYy4QYtYYz3dtX8RODlOsvu
 RfwGYRdzba4PJyFCLWIzkRPpJzUflbkjqWPHMv+DeGIS3VKx4/bNbgbW+XRBa6YeTY5x
 EMlN0gCl24OhaYPv+gCrwlFNqoX7e7g3z7MHoQzZPO2RXs9LTAJ641WEHN01zMaPOQFu
 Sl2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzERe6doW1ydI1VlpAsE/JhlieKpBHZEsCSUWpUoeLceRit3325G7hoAFmorztS/wRzp1cDiwwP6VI@nongnu.org
X-Gm-Message-State: AOJu0YzmnSq9yqWzJuXsbME7KguQf/+YiektjesLJAZySmvKzAHdkIgu
 wqEFCLqXtCBF4u7d9XJg+RMUtwUxGSsMdVFCWS+FdzRBQxzzFbACEvtegtltxNHzrD+JmfPU0BA
 vv3uNawkR7kVmmDjTzpv6+w9VcqX5UgARpka3ZcqDq8kt4zKwMsTN
X-Gm-Gg: ASbGncuD+PsL5kC1xR7lxX+jrTSDALZO5/lApBDblpZe0fmQOD3RdVZRVQeMq8Trvvl
 I2qMFN5x5tf1YL5YRo2ymiIdJ0u2PxVsT+DP6XrgM9nEkNuBbzMgEx60BJmlVpoXjP28GUDMpZL
 Shi7CHFFHG7/1YzzHrRaos838FtDRDMj+BXa7qV0IZx9wQ2Yz6Lk7wQ0wcSlO2MeTcsm9C7U1RO
 Kp8dboGr7lBE6Idzu8obfw0HoNdhc6yTCJQfinsb8Grtg5NWOOwMoezlajamlhM8fMf30ITW5hi
 l1sZRTKWLjZFqHZuLQoRgHK9aHX24tyd6vOwuJSzs+0Ma6rCAMqRFH3aOiOiwnwDOkqdyeaTbwB
 jhpTmIPoSQmBs7Uk0b8HGE9hWSUW0/LFuBUnsSOjmTvLk
X-Received: by 2002:a5d:59a9:0:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-3997f908b69mr22437941f8f.20.1742998713614; 
 Wed, 26 Mar 2025 07:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLnRH9SLkA0Dj91P4IHt3rAITyt1zeK6HmL9JbL23iYLfcW5hetQjZq2+M7UIvah+yDgvGcw==
X-Received: by 2002:a5d:59a9:0:b0:391:2dea:c9a5 with SMTP id
 ffacd0b85a97d-3997f908b69mr22437912f8f.20.1742998713130; 
 Wed, 26 Mar 2025 07:18:33 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d8b:cdca:4048:2991:54ce?
 (p200300cfd74f9d8bcdca4048299154ce.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d8b:cdca:4048:2991:54ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39ac80e6814sm5366599f8f.56.2025.03.26.07.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 07:18:32 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------ufLCMU0sftvhuecAo7032DAt"
Message-ID: <2e1e5f28-8d2c-4e3c-afae-a65a9adc85ad@redhat.com>
Date: Wed, 26 Mar 2025 15:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "iotests: Stop NBD server in test 162 before
 starting the next one"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org
References: <20250326123827.920305-1-thuth@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250326123827.920305-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is a multi-part message in MIME format.
--------------ufLCMU0sftvhuecAo7032DAt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.03.25 13:38, Thomas Huth wrote:
> From: Thomas Huth<thuth@redhat.com>
>
> This reverts commit e2668ba1ed44ad56f2f1653ff5f53b277d534fac.
>
> This commit made test 162 fail occasionally with:
>
>   162   fail       [13:06:40] [13:06:40]   0.2s   (last: 0.2s)  output mismatch
>   --- tests/qemu-iotests/162.out
>   +++ tests/qemu-iotests/scratch/qcow2-file-162/162.out.bad
>   @@ -3,6 +3,7 @@
>    === NBD ===
>    qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address
>     resolution failed for -1:10809: Name or service not known
>    image: nbd://localhost:PORT
>   +./common.rc: line 371: kill: (891116) - No such process
>    image: nbd+unix://?socket=42
>
> The nbd server should normally terminate automatically, so trying to
> kill it here now seems to cause a race that will cause a test failure
> when the server terminated before the kill command has been executed.
>
> The "Stop NBD server" patch has originally been written to solve another
> problem with a hanging nbd server, but since that problem has been properly
> solved by commit 1453e04c63, we now don't need the "_stop_nbd_server" here

I can’t find that hash; do you mean 3e1683485656?

> anymore.
>
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   tests/qemu-iotests/162 | 1 -
>   1 file changed, 1 deletion(-)

With the hash fixed (or explained where I have to look :)):

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
--------------ufLCMU0sftvhuecAo7032DAt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 26.03.25 13:38, Thomas Huth wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250326123827.920305-1-thuth@redhat.com">
      <pre wrap="" class="moz-quote-pre">From: Thomas Huth <a class="moz-txt-link-rfc2396E" href="mailto:thuth@redhat.com">&lt;thuth@redhat.com&gt;</a>

This reverts commit e2668ba1ed44ad56f2f1653ff5f53b277d534fac.

This commit made test 162 fail occasionally with:

 162   fail       [13:06:40] [13:06:40]   0.2s   (last: 0.2s)  output mismatch
 --- tests/qemu-iotests/162.out
 +++ tests/qemu-iotests/scratch/qcow2-file-162/162.out.bad
 @@ -3,6 +3,7 @@
  === NBD ===
  qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address
   resolution failed for -1:10809: Name or service not known
  image: nbd://localhost:PORT
 +./common.rc: line 371: kill: (891116) - No such process
  image: nbd+unix://?socket=42

The nbd server should normally terminate automatically, so trying to
kill it here now seems to cause a race that will cause a test failure
when the server terminated before the kill command has been executed.

The "Stop NBD server" patch has originally been written to solve another
problem with a hanging nbd server, but since that problem has been properly
solved by commit 1453e04c63, we now don't need the "_stop_nbd_server" here</pre>
    </blockquote>
    <br>
    I can’t find that hash; do you mean 3e1683485656?<br>
    <br>
    <blockquote type="cite"
      cite="mid:20250326123827.920305-1-thuth@redhat.com">
      <pre wrap="" class="moz-quote-pre">
anymore.

Signed-off-by: Thomas Huth <a class="moz-txt-link-rfc2396E" href="mailto:thuth@redhat.com">&lt;thuth@redhat.com&gt;</a>
---
 tests/qemu-iotests/162 | 1 -
 1 file changed, 1 deletion(-)
</pre>
    </blockquote>
    <br>
    With the hash fixed (or explained where I have to look :)):<br>
    <br>
    Reviewed-by: Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a><br>
  </body>
</html>

--------------ufLCMU0sftvhuecAo7032DAt--


