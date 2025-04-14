Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBF7C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 13:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4K24-0005KO-Nx; Mon, 14 Apr 2025 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u4K1n-0005Ix-7W
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 09:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u4K1l-0006o1-7e
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 09:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744637947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m1aUejJxvqHHI3guugDPLcnWs0gXUgzRO0DgXY4fBe4=;
 b=KJPNvv6CYTauhHZsT2cUkxTN/rrTlk5Ch0jHeeVLnoKrdF8Gzrx1o6ubtfzepYdlvCvu0D
 n2X0LbdyQ08zvWOMaOX2sIOdEn1Wf+MaCkLC+OzNxNutcHUvsOhKloNbkde4FC6dBXBwTN
 fDk+sOnV/kdCefKZtyFDOe//Pr8kmpA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-sQR92i0vMvWQakjvr5-rkQ-1; Mon, 14 Apr 2025 09:39:04 -0400
X-MC-Unique: sQR92i0vMvWQakjvr5-rkQ-1
X-Mimecast-MFC-AGG-ID: sQR92i0vMvWQakjvr5-rkQ_1744637944
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913f546dfdso2437879f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 06:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744637944; x=1745242744;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m1aUejJxvqHHI3guugDPLcnWs0gXUgzRO0DgXY4fBe4=;
 b=sCyAN0wpqwUS5ycM8BQelThPs10d4cNZl6o06mtgkJ1QY1d1qIMozBaQJYcWjDEwCG
 fN8v9wxV8ah6sCgjfm+9mS0KjLVh2FyFGDxO2DQQoqBAWJPX4ObHjgjsWZjjjPdI8l5V
 /P/kYdJJA7PlXsEhFH91ocBps7OnYjLHvp6nxe8UPBCTUHPAIHf7RjojLZsxOJhF0zUu
 PQoh6en/Ks1ZI4/EPPbc8JmaOxJUq+/t0z0cJbOvQKt7e526+p6Kfx0LgoDJQgjTv/WI
 HFv1FcVN+LlsxVd0D9FbcQiWrW1ewhNxQXwiY4hI8V744/efbEOq/p1Z7JAmTc//MKD1
 OHmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTy8qJr7mv7Qp0YBYzMa0GM0ZQLKYKmgt1n7A6izTwFSgb4uYUZ8KD/IFm4mmZaNaDbQIdyRkClv96@nongnu.org
X-Gm-Message-State: AOJu0YxUrlCmVBL8cCZNO5Qp2BJnhBOdvNNDE++psuDqMou8CZeq736z
 xnWP4G0LHE/tkMl1BVr06O3X8zMkjBI2zxtO2NPT/wF1JFwL42/zlRupbnrwCAbEOexk/o2R7w1
 SS9mpQJU0rl/OOE8Qh6lyYlIq0ZqC0ANdnXdwMFh6DpON97gGjlNN
X-Gm-Gg: ASbGncuaODMxYrrqlW0ZCYrFF8nQN9S3UIpoj0AqZPXM/o9rfip27l5DI5ikrLrn7Dt
 VUlu+8H6IruRabMfVpAhDr5p3EA6S2muuhca3qAewvxS9QJgdiTtAUqVYytG8UQZwJaoKoTRgdY
 YPEo5jZ4mYeJJvPNf3FdVVmJ0r8XDWuKiVUIggZ45WMXUUKfiC/phhgM7N8McpF5rDf08SuVyKt
 xvw/i+3+glrO4v9cEBBjClAJsj6iXRCSkxCZ3EqbzbrhV9aphVbZtywTk1iIX46gEvxkVkl6lWp
 Q5OYdbQEC/S4U1AQ4fgtZKDAv0sdJPb2nZXt696VcoEjrNTk246iGXXOgypdxA3aEftJRaC+frw
 AhAooa6t/Evzlm59PmLW0pRihnXjA/EfOZShQ9egR
X-Received: by 2002:a05:6000:2582:b0:39c:e0e:bb48 with SMTP id
 ffacd0b85a97d-39ea51d1300mr9576419f8f.8.1744637943514; 
 Mon, 14 Apr 2025 06:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXG3U1IDLVwOPkvQErhvRcNrn/rJVMG5zSYcdjCabMtubpmx2/+331tOM/7FteZZMhpxgGkg==
X-Received: by 2002:a05:6000:2582:b0:39c:e0e:bb48 with SMTP id
 ffacd0b85a97d-39ea51d1300mr9576394f8f.8.1744637943108; 
 Mon, 14 Apr 2025 06:39:03 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:a288:2aea:8fa5:277f:56f7?
 (p200300cfd71aa2882aea8fa5277f56f7.dip0.t-ipconnect.de.
 [2003:cf:d71a:a288:2aea:8fa5:277f:56f7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445315sm10984735f8f.82.2025.04.14.06.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 06:39:02 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------q6ST0sqDY1IDOcNAdfYgk9Zl"
Message-ID: <adc28b50-9d9e-4565-8f52-9087787fe31b@redhat.com>
Date: Mon, 14 Apr 2025 15:39:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block/io: skip head/tail requests on EINVAL
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
References: <20250410184103.23385-1-stefanha@redhat.com>
 <20250410184103.23385-3-stefanha@redhat.com>
 <c2daf7e2-359b-4e4b-826f-511fa9c0e3fb@redhat.com>
 <sqmppkfqoxnivqod7lrwfb5aji2d2dfos3opru2wdzf4nwfgws@xg3lmrtjgkxl>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <sqmppkfqoxnivqod7lrwfb5aji2d2dfos3opru2wdzf4nwfgws@xg3lmrtjgkxl>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
--------------q6ST0sqDY1IDOcNAdfYgk9Zl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.25 19:28, Eric Blake wrote:
> On Fri, Apr 11, 2025 at 10:18:55AM +0200, Hanna Czenczek wrote:
>>>            if (ret && ret != -ENOTSUP) {
>>> -            goto out;
>>> +            if (ret == -EINVAL && (offset % align != 0 || num % align != 0)) {
>> Could use `(offset | num) % align != 0`, but either way:
> Use of | and & to perform alignment checks only works if align is
> guaranteed to be a power of 2.  But isn't there (odd) hardware out
> there with something like a 15M alignment, at which point you HAVE to
> do separate checks with % because bitwise ops no longer work?

Ah, true, thanks!

Hanna
--------------q6ST0sqDY1IDOcNAdfYgk9Zl
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 11.04.25 19:28, Eric Blake wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:sqmppkfqoxnivqod7lrwfb5aji2d2dfos3opru2wdzf4nwfgws@xg3lmrtjgkxl">
      <pre wrap="" class="moz-quote-pre">On Fri, Apr 11, 2025 at 10:18:55AM +0200, Hanna Czenczek wrote:
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">          if (ret &amp;&amp; ret != -ENOTSUP) {
-            goto out;
+            if (ret == -EINVAL &amp;&amp; (offset % align != 0 || num % align != 0)) {
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Could use `(offset | num) % align != 0`, but either way:
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Use of | and &amp; to perform alignment checks only works if align is
guaranteed to be a power of 2.  But isn't there (odd) hardware out
there with something like a 15M alignment, at which point you HAVE to
do separate checks with % because bitwise ops no longer work?
</pre>
    </blockquote>
    <span style="white-space: pre-wrap">
</span><br>
    Ah, true, thanks!<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------q6ST0sqDY1IDOcNAdfYgk9Zl--


