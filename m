Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E67CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v783O-0004xp-9J; Fri, 10 Oct 2025 04:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v783M-0004xX-Jk
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v783G-00037w-Pi
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760083231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dnd0/9+udrZrEqnDaoetGQDB+anUwd1Yh6kJAHctUkA=;
 b=PfF934DauyOb3wRsHVYzMk2GhriOELEx9zi9Sqonsj4GDKLT40QdGLie76hnFN+hsVcwnv
 I0Oa5pT4eS6ql+7y3WJIdMLMH9kdwfKzSV2cqPatFGqR4gHDaCGWnp4yAaQ7v3PwdCzLim
 YlYyjiCdEpNmTSISG0T3R6eeCV7pBEI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-9sN5xQUuMpyc7fIgdjztXQ-1; Fri, 10 Oct 2025 04:00:30 -0400
X-MC-Unique: 9sN5xQUuMpyc7fIgdjztXQ-1
X-Mimecast-MFC-AGG-ID: 9sN5xQUuMpyc7fIgdjztXQ_1760083229
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-afe81959e5cso192647166b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 01:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760083229; x=1760688029;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dnd0/9+udrZrEqnDaoetGQDB+anUwd1Yh6kJAHctUkA=;
 b=WmrmEDpjDf7QUFiLlq1HrXTxgREByu50v/ibDGtxigDyVrBHVRrB8mnK1ZroKlU3WF
 2VjddMel+aGZyF+7MA7j2zbCAlZEnWvd4NIvnCpljzXQTTUG3R7rRo2q5P17W4Gl2AxP
 GVAeWgo8Vzw96MBChiztCXX27B8trPr9tf+59H+lgCDX+7NZMrxn9lm19gS8IvIH8oCu
 wbrCkWPa4/7Z1mRNIcLJavqguAPzyNSDHfBdhQA/UUWNNV4LY7Xkmc/G8DQIvghC3fmH
 PwPHZ+L7n3J36sNXzwBxj6K/pILqmZngFQsQJ9TOMYC6l0ZweEAiSA8Ffb+YHx9k5WNo
 xteA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXewXoM0puSiGaI7jD3UG/ngRRuo+trQEkAejRfmaN4FNJncb0ED6nucJS86E/Xnc5qygrU+V6ViKIw@nongnu.org
X-Gm-Message-State: AOJu0YzwGkH3V+ywpHtDudyP59CUPA9uvIBPk7TpqPdxCZl9+czB2byX
 H/8iMGJmAhE7DiFJZZiHGT2Da9OcAcy5SepSAex8myWpJFBcbO7JJQ38tBVkQhdqblTuf17HQ7/
 hRCscl/OBqWIoSsGTcDZSpHLf5GzVdYlz0kRGWTVAgpVTjs0Ze02NtOj9
X-Gm-Gg: ASbGnctvey0L6vQ/u+WJ5YEdGnGm2ySYrpl3mjHCdwMAfUxayKqVcRROO8vYnmQ0im/
 Q4/NH4HfD0DggKTa1HjCyx2LZXYrNbucqAVnImPU/J8qFRO8r/eGLOumQFSqc1rWda6672JsQgL
 mqkPtsp1X2gStljxksWG2HtbdSQfXG/tTxhQvsVX39RndUsiI/Jy+UhyeR99OtFlR7DNKvyw7jj
 lt71Qz7AoGvj/oxg0WQnLrWe+8XfTYKIo3EfEREuypecLOaKdAIt5S+xNXbqKYs6FmoG7HEw94W
 fPWKfTzIWDy8lg0fckEDHaHX7ouZDCdiYsODcN6GK5ac3JI/uqTu0BZajLx4dJe0nrNuxCLiunL
 g7hfq
X-Received: by 2002:a17:906:71c5:b0:b53:e871:f0ea with SMTP id
 a640c23a62f3a-b53e871f673mr726344866b.56.1760083229015; 
 Fri, 10 Oct 2025 01:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw7O1R4eRhxUEIlOwaVGSSYnDW+FDMQx9Tle0LvLxfWVekfnftKxZZ1VYn0wntOu3XG1U8sg==
X-Received: by 2002:a17:906:71c5:b0:b53:e871:f0ea with SMTP id
 a640c23a62f3a-b53e871f673mr726320366b.56.1760083223262; 
 Fri, 10 Oct 2025 01:00:23 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d69dbd99sm168711766b.40.2025.10.10.01.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 01:00:22 -0700 (PDT)
Message-ID: <9ad2350a-d640-4fcf-8804-d085a0f87ed4@redhat.com>
Date: Fri, 10 Oct 2025 10:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: iotest 233 is failing (was: [PULL 27/45] io/crypto: Move tls
 premature termination handling into QIO layer)
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-28-peterx@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251003153948.1304776-28-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 03/10/2025 17.39, Peter Xu wrote:
> QCryptoTLSSession allows TLS premature termination in two cases, one of the
> case is when the channel shutdown() is invoked on READ side.
  Hi Peter,

this patch break iotest 233 for me:

thuth:~/tmp/qemu-build$ cd tests/qemu-iotests/
thuth:~/tmp/qemu-build/tests/qemu-iotests$ ./check 233
QEMU          -- "/home/thuth/tmp/qemu-build/qemu-system-x86_64" -nodefaults 
-display none -accel qtest
QEMU_IMG      -- "/home/thuth/tmp/qemu-build/qemu-img"
QEMU_IO       -- "/home/thuth/tmp/qemu-build/qemu-io" --cache writeback 
--aio threads -f raw
QEMU_NBD      -- "/home/thuth/tmp/qemu-build/qemu-nbd"
IMGFMT        -- raw
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 thuth-p1g4 6.16.10-200.fc42.x86_64
TEST_DIR      -- /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/qemu-iotests-eidif2rs
GDB_OPTIONS   --
VALGRIND_QEMU --
PRINT_QEMU_OUTPUT --

233   fail       [09:58:28] [09:58:30]   2.5s   (last: 2.0s)  output 
mismatch (see 
/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/raw-file-233/233.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/233.out
+++ 
/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/raw-file-233/233.out.bad
@@ -43,51 +43,37 @@

  == check TLS fail over TCP with mismatched hostname ==
  qemu-img: Could not open 
'driver=nbd,host=localhost,port=PORT,tls-creds=tls0': Certificate does not 
match the hostname localhost
-qemu-nbd: Certificate does not match the hostname localhost
+qemu-nbd: Failed to read initial magic: Unable to read from socket: 
Connection reset by peer

  == check TLS works over TCP with mismatched hostname and override ==
-image: nbd://localhost:PORT
-file format: nbd
-virtual size: 64 MiB (67108864 bytes)
-disk size: unavailable
-exports available: 1
- export: ''
-  size:  67108864
-  min block: 1
-  transaction size: 64-bit
+qemu-img: Could not open 
'driver=nbd,host=localhost,port=PORT,tls-creds=tls0,tls-hostname=127.0.0.1': 
Failed to connect to 'localhost:PORT': Connection refused
+qemu-nbd: Failed to connect to 'localhost:10809': Connection refused

  == check TLS with different CA fails ==
-qemu-img: Could not open 
'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't 
got a known issuer
-qemu-nbd: The certificate hasn't got a known issuer
+qemu-img: Could not open 
'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to connect to 
'127.0.0.1:PORT': Connection refused
+qemu-nbd: Failed to connect to '127.0.0.1:10809': Connection refused

  == perform I/O over TLS ==
-read 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 1048576/1048576 bytes at offset 1048576
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open: Failed to connect to '127.0.0.1:10809': Connection refused
+Pattern verification failed at offset 1048576, 1048576 bytes
  read 1048576/1048576 bytes at offset 1048576
  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

  == check TLS with authorization ==
-qemu-img: Could not open 
'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option 
reply: Cannot read from TLS channel: The TLS connection was non-properly 
terminated.
-qemu-img: Could not open 
'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': Failed to read option 
reply: Cannot read from TLS channel: The TLS connection was non-properly 
terminated.
+./common.nbd: line 38: kill: (545045) - No such process
+./common.rc: line 208: 545147 Segmentation fault      (core dumped) ( 
VALGRIND_QEMU="${VALGRIND_QEMU_IMG}" _qemu_proc_exec "${VALGRIND_LOGFILE}" 
"$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
+./common.rc: line 208: 545163 Segmentation fault      (core dumped) ( 
VALGRIND_QEMU="${VALGRIND_QEMU_IMG}" _qemu_proc_exec "${VALGRIND_LOGFILE}" 
"$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )

  == check TLS fail over UNIX with no hostname ==
  qemu-img: Could not open 
'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0': No hostname for 
certificate validation
-qemu-nbd: No hostname for certificate validation
+qemu-nbd: Failed to read initial magic: Unable to read from socket: 
Connection reset by peer

  == check TLS works over UNIX with hostname override ==
-image: nbd+unix://?socket=SOCK_DIR/qemu-nbd.sock
-file format: nbd
-virtual size: 64 MiB (67108864 bytes)
-disk size: unavailable
-exports available: 1
- export: ''
-  size:  67108864
-  min block: 1
-  transaction size: 64-bit
+qemu-img: Could not open 
'driver=nbd,path=SOCK_DIR/qemu-nbd.sock,tls-creds=tls0,tls-hostname=127.0.0.1': 
Failed to connect to 
'/tmp/qemu-iotests-eidif2rs/raw-file-233/qemu-nbd.sock': Connection refused
+qemu-nbd: Failed to connect to 
'/tmp/qemu-iotests-eidif2rs/raw-file-233/qemu-nbd.sock': Connection refused

  == check TLS works over UNIX with PSK ==
+./common.nbd: line 38: kill: (545184) - No such process
  image: nbd+unix://?socket=SOCK_DIR/qemu-nbd.sock
  file format: nbd
  virtual size: 64 MiB (67108864 bytes)
@@ -103,14 +89,8 @@
  qemu-nbd: TLS handshake failed: The TLS connection was non-properly 
terminated.

  == final server log ==
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read 
from TLS channel: The TLS connection was non-properly terminated.
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read 
from TLS channel: The TLS connection was non-properly terminated.
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
-qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
  qemu-nbd: option negotiation failed: TLS x509 authz check for 
DISTINGUISHED-NAME is denied
  qemu-nbd: option negotiation failed: TLS x509 authz check for 
DISTINGUISHED-NAME is denied
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read 
from TLS channel: The TLS connection was non-properly terminated.
-qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot read 
from TLS channel: The TLS connection was non-properly terminated.
  qemu-nbd: option negotiation failed: TLS handshake failed: An illegal 
parameter has been received.
  qemu-nbd: option negotiation failed: TLS handshake failed: An illegal 
parameter has been received.
  *** done
Failures: 233
Failed 1 of 1 iotests

Could you please have a look?

  Thanks,
   Thomas


