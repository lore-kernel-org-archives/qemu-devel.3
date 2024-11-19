Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A69D62073
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 17:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDRl6-0005UP-A2; Tue, 19 Nov 2024 12:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDRl4-0005U1-JX
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDRl2-0001A1-TJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 12:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732036278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sa7oz+Mf7B+3XHkzeC7VS7bGvLdgsKj2/t50biZy4aA=;
 b=Ms9YDKFrBjHnCNhlSu6w1iOtiL7AA2t4Oznsrd8IcI4q2NysOgk+1SlsXckrFtc0kYijX9
 eFOf3du1PbcOvzf5kZpj+s8I3dcrcfPq3Zb+jdMJaDwa9CufxZuvU5CCN52yaMBDRgOg7g
 wd5B+ygYcpQSqmRAO3/vEbRX9pldWCg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-G3OfTvfpMySbWFP56SGzfg-1; Tue, 19 Nov 2024 12:11:15 -0500
X-MC-Unique: G3OfTvfpMySbWFP56SGzfg-1
X-Mimecast-MFC-AGG-ID: G3OfTvfpMySbWFP56SGzfg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3823527eb9dso1909952f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 09:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732036274; x=1732641074;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sa7oz+Mf7B+3XHkzeC7VS7bGvLdgsKj2/t50biZy4aA=;
 b=xBA9KqmR4aznpsi2ffVOfY7UumFMch+mzsdglwObiUCYNgzOVhuWPaX6YZ2ndZXR0C
 NbLL3xQ0qp9PfiEFd6owRvSh2qnR2oGVW9U9GIxF/dilm/P8fzDx4I1etO/G+BC5N0Fy
 Kxzx0v/jlbmICGycB0b5niTetI+VBJ6N87Wi21yZ+K6tF0vDk0UZobJEYn6lGo0Rt8p8
 6KE6cXXf+Lkk2Of6f56KY34McqWdnz11jtxOvVWMyau8re83mIzua2JoIxhKKlNano/4
 J3wRUWTxW7xZ9Iv6njOS/fg5q3Frd7S28wjmL+PJKmyaMU116ocbcYAXV4GMMML69l0e
 tBXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2eKept9T0NMslGYIWSWAAjsdAtenFD2xi0igPCY1UqIclrQzU0Q4Ipl6WRq90Lr/i7gSDyhRErQKh@nongnu.org
X-Gm-Message-State: AOJu0YzA8M1YsrcYF+ubaDfKFrCOTKYh89mgyhJr+XB7ZJecWLgRehHr
 RZZdo1yQKN71RPXdpKAb/rGXd73XvN8WDtFU73o6nck3T+0qMy8eop7OQfInZcqo2bgNVamEA2o
 eP6bvQTsXK4wp5Y00ZeKb/Et4hVvDqEgSrvPsDGjIfHJ25Q2dC21t
X-Received: by 2002:a5d:5988:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-38225aaef32mr15021561f8f.48.1732036273975; 
 Tue, 19 Nov 2024 09:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKhRwpbimetE6JMLm1zUf50wrPrzg9kywV5ZSp8wdw6k5CQw7cxniDnd2eJxE8rjdk+3D8Nw==
X-Received: by 2002:a5d:5988:0:b0:37c:cc67:8b1f with SMTP id
 ffacd0b85a97d-38225aaef32mr15021545f8f.48.1732036273678; 
 Tue, 19 Nov 2024 09:11:13 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38232cde8dasm11424843f8f.103.2024.11.19.09.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 09:11:13 -0800 (PST)
Message-ID: <beb4abeb-299a-4d4a-a253-3e65a41edcc9@redhat.com>
Date: Tue, 19 Nov 2024 18:11:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] tests/functional: rewrite console handling to be
 bytewise
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-14-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241119150519.1123365-14-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/19/24 16:05, Daniel P. Berrangé wrote:
> The console interaction that waits for predicted strings uses
> readline(), and thus is only capable of waiting for strings
> that are followed by a newline.
> 
> This is inconvenient when needing to match on some things,
> particularly login prompts, or shell prompts, causing tests
> to use time.sleep(...) instead, which is unreliable.
> 
> Switch to reading the console 1 byte at a time, comparing
> against the success/failure messages until we see a match,
> regardless of whether a newline is encountered.
> 
> The success/failure comparisons are done with the python bytes
> type, rather than strings, to avoid the problem of needing to
> decode partially received multibyte utf8 characters.
> 
> Heavily inspired by a patch proposed by Cédric, but written
> again to work in bytes, rather than strings.
> 
> Co-developed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py | 63 +++++++++++++++++++++++--------
>   1 file changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index 76a48064cd..91267a087f 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -78,15 +78,58 @@ def run_cmd(args):
>   def is_readable_executable_file(path):
>       return os.path.isfile(path) and os.access(path, os.R_OK | os.X_OK)
>   
> +def _console_readline(test, vm, success, failure):
> +    msg = bytes([])
> +    done = False
> +    while True:
> +        c = vm.console_socket.recv(1)
> +        if c is None:
> +            done = True
> +            test.fail(
> +                f"EOF in console, expected '{success}'")
> +            break
> +        msg += c
> +
> +        if success is None or success in msg:

As an optimization, you could use msg.endswith(success) and 
msg.endswith(failure), which would avoid the most blatant cases of 
O(n^2) behavior.

More important, I think "if success is None" should not be here, because 
it will exit after one char.  Instead...

> +            done = True
> +            break
> +        if failure and failure in msg:
> +            done = True
> +            vm.console_socket.close()
> +            test.fail(
> +                f"'{failure}' found in console, expected '{success}'")
> +
> +        if c == b'\n':

Here you can put

                done = success is None

Paolo

> +            break
> +
> +    console_logger = logging.getLogger('console')
> +    try:
> +        console_logger.debug(msg.decode().strip())
> +    except:
> +        console_logger.debug(msg)
> +
> +    return done
> +
>   def _console_interaction(test, success_message, failure_message,
>                            send_string, keep_sending=False, vm=None):
>       assert not keep_sending or send_string
>       if vm is None:
>           vm = test.vm
> -    console = vm.console_file
> -    console_logger = logging.getLogger('console')
> +
>       test.log.debug(f"Console interaction success:'{success_message}' " +
>                      f"failure:'{failure_message}' send:'{send_string}'")
> +
> +    # We'll process console in bytes, to avoid having to
> +    # deal with unicode decode errors from receiving
> +    # partial utf8 byte sequences
> +    success_message_b = None
> +    if success_message is not None:
> +        success_message_b = success_message.encode()
> +
> +    failure_message_b = None
> +    if failure_message is not None:
> +        failure_message_b = failure_message.encode()
> +
>       while True:
>           if send_string:
>               vm.console_socket.sendall(send_string.encode())
> @@ -99,20 +142,10 @@ def _console_interaction(test, success_message, failure_message,
>                   break
>               continue
>   
> -        try:
> -            msg = console.readline().decode().strip()
> -        except UnicodeDecodeError:
> -            msg = None
> -        if not msg:
> -            continue
> -        console_logger.debug(msg)
> -        if success_message is None or success_message in msg:
> +        if _console_readline(test, vm,
> +                             success_message_b,
> +                             failure_message_b):
>               break
> -        if failure_message and failure_message in msg:
> -            console.close()
> -            fail = 'Failure message found in console: "%s". Expected: "%s"' % \
> -                    (failure_message, success_message)
> -            test.fail(fail)
>   
>   def interrupt_interactive_console_until_pattern(test, success_message,
>                                                   failure_message=None,


