Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4504D29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYuC-0000Hp-1J; Tue, 13 Jan 2026 02:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfYtw-0008Ln-Hy
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:33:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfYts-000767-Lj
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768289592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+cvhzN6ZgF5buGwzYRSEhRLAPHNkQ2/eGV+UlHtYL64=;
 b=Z9fxIoaF0FodEQt09KQrWyp6tZxVH7IPd8mRfLVzZQ2mPXeK8BKWU49R5bMD8xL+URoYN7
 XQyI56HLcHjwTDMQYvQSNTuAOiMTsbB/CZTS7o3eAePe6FgPIk3jpS2y8vXSnXZY5m7LYs
 KdXRBWdO4ELisZivHpu5qyl7HdlBY+g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-JiTwaI7VMh-sTChBdcCvtg-1; Tue, 13 Jan 2026 02:33:10 -0500
X-MC-Unique: JiTwaI7VMh-sTChBdcCvtg-1
X-Mimecast-MFC-AGG-ID: JiTwaI7VMh-sTChBdcCvtg_1768289589
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b8715782415so20524166b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768289589; x=1768894389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+cvhzN6ZgF5buGwzYRSEhRLAPHNkQ2/eGV+UlHtYL64=;
 b=Gf/OODCKiubMaL3ELoUpV/w2GhF8q/5DVHvszxbAVELncD2/K5Y/cXZ+TBAAJRkxqC
 RbEZdSF0Cel0R2IkVa/myNHS/2HsxxUXXhM158kGpFPg2nKinw1QdAxWp7mKUeh0FqrC
 5rRFzwtzapkhhIFF178WbfpTA1D64s2lTtCloHgK37+cRLKhU5A/clgLxgipN4XwEiVZ
 oVKBJppcO3rGGqrQyRLV+Sz5Uo5AdATaOW8eGAowXY3yc4Vq+fse54rBlx1IbrXo6kBq
 jnLC8tFGAa3CMWEXH7uJw5QcI8e6MTdBsAVkEZ6tsZhnfIUCiQKfkKMs1eVfGWWAdTMn
 0aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768289589; x=1768894389;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cvhzN6ZgF5buGwzYRSEhRLAPHNkQ2/eGV+UlHtYL64=;
 b=H3xPgh8MX6Uohnbbjaf4qDyWAi+EVkWMyPp4+QFGi3DYr6k0FcPDAQ5eAiws6s4leT
 73jQbNTH68xKzkYUnA6Aznvl98lSwfB5ZyVsWwhKkINGzxLoEIWT79w8LW1CcWNQaRh8
 nyQX3Dc7nO2FC73e3Rsez5N3o8HzL0wr9vfTmUct3H6PAWXqQZG3NbEP0ZExU+LbofrV
 CTjCXaKi5hKSCTP7x/lLj69CWvnyQBZjqdThhUdHqiSGoHgVlUZyFqbLaG2urJcx0HGv
 Y1upyY3ADhZgwwOmwPDyIj+lycBDtAadMVhJZx+R3jR+lJ14Kho7hTY8lwc8Npgd5Qv6
 0/tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1H9IVYRq/ICw7xf4ViLe0qVlsj7r+Wk0bwswJ0e7aLy9K/D7Xul6qkoJeLbKmEfda0suRJt6UYUGE@nongnu.org
X-Gm-Message-State: AOJu0Yx0gHBY+EOYUDe6sb6K6wKdJtjOXe1ePSS+6j/K+5+lUa61oYkw
 6T10w3M3EicrCIZUYgZn0yinfuiREAj6wJjSbdtZYYwP1tQ0StzrpZEENnB5z99Qj/V5O5DrUXV
 xYZDbt9iB9pKIGb2N1dOQ6xkgNp4GdseKB8Okb65RwA4kJrQk1wFLaP/F
X-Gm-Gg: AY/fxX55dP3HKfZxyTT6fSmHGY89MgjDWVQWzXIasC9wYq17Vd1wwBBZDgMt530MUDe
 3sZl3i1GueGLeqctUtpG02CEaUXUUeJXowAC89b+0bZ+ywep2L04rTYQ/HlHirPw6LpR1+PUTBL
 Rlipc3T9ZUPmdafYEcZKxk3aI7bcdGzoqWF7EiyqYOBhoHhhDYYOdN1LJPU58IXdL20czOpMAbZ
 ccWa2DJgrncD2X7ua7Wt0YJuG8KbMPacJ/Elda6Z63QVXutSYWLFnRwrDp4Ynx/qY8wc8xS3ZgK
 +dodQfaE+KN97cLymylvcrMFZWH4obssA5GvMS3n4Yo5+OGyDVaT/AWZDspJF98uwry8KXEmq4P
 sy7ydDp8=
X-Received: by 2002:a17:907:961e:b0:b87:2471:def3 with SMTP id
 a640c23a62f3a-b872471ec38mr477628666b.55.1768289589207; 
 Mon, 12 Jan 2026 23:33:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9ePugTiN2AWi9ksYOYya9p9MRyi83T/avyPHxQsSme33F+3zRQdxHGOs3l4W2NXUDLjbSZw==
X-Received: by 2002:a17:907:961e:b0:b87:2471:def3 with SMTP id
 a640c23a62f3a-b872471ec38mr477626566b.55.1768289588787; 
 Mon, 12 Jan 2026 23:33:08 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a563f0esm2199055966b.60.2026.01.12.23.33.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:33:08 -0800 (PST)
Message-ID: <051d1efb-dc31-461c-b17a-fb4c24ccc273@redhat.com>
Date: Tue, 13 Jan 2026 08:33:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
To: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Navid Emamdoost <navidem@google.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, stefanha@redhat.com, farosas@suse.de,
 darren.kenny@oracle.com, Qiuhao.Li@outlook.com, lvivier@redhat.com,
 zsm@google.com, Fabiano Rosas <farosas@suse.de>
References: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
 <20251112003637.1984547-1-navidem@google.com>
 <20251112003637.1984547-2-navidem@google.com>
 <CAHUE=o8u1snmMBGHExoZix3vFY6Y8J_jWdYKNDiuMd6jvw0qzQ@mail.gmail.com>
 <aV0EtXyfCmpSUvg8@redhat.com>
 <CAHUE=o_F=b3PHZQjZ_tA5gVDPXF_FixZ5na5ymxZWkBy_oEZtg@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAHUE=o_F=b3PHZQjZ_tA5gVDPXF_FixZ5na5ymxZWkBy_oEZtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/01/2026 05.06, Alexander Bulekov wrote:
> On 260106 1249, Daniel P. Berrangé wrote:
>> Hi Alexander,
>>
>> I don't see this old fuzzing patch merged yet. Who is normally collecting
>> and merging fuzz patches ?
> 
> Hi Daniel,
> In the past, as far as I remember it has been either me or Thomas. I can
> put together the pull-req. Apologies for the delay

  Hi,

FYI, I handed over the maintainership of the qtests to Fabiano Rosas, so I'm 
not looking for qtest-related patches anymore. Please CC: Fabiano if you 
want to get something merged by him. Thanks!

  Regards,
   Thomas


>>
>> On Fri, Nov 14, 2025 at 09:02:06AM -0600, Alexander Bulekov wrote:
>>> On 251112 0036, Navid Emamdoost wrote:
>>>> Add a new generic fuzz target for the QEMU VNC server. This target
>>>> exercises both the standard VNC protocol and the VNC-over-WebSocket
>>>> transport layer, increasing coverage of a primary remote attack surface.
>>>>
>>>> To support parallel fuzzing (e.g., with oss-fuzz), the VNC unix
>>>> socket paths are generated dynamically. The fuzzer harness inspects the
>>>> command line for placeholders and replaces them with unique paths
>>>> created by mkstemp() before execution.
>>>>
>>>> ---
>>>>
>>>> This new target increases code coverage in the VNC subsystem
>>>> and related networking and I/O code.
>>>> The baseline coverage below was generated by running all existing fuzz
>>>> targets with the oss-fuzz corpus. The new target shows significant gains:
>>>>
>>>> ----------------------------------------------------------------------------
>>>> File                       New Target                Baseline        Change
>>>> ----------------------------------------------------------------------------
>>>> vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
>>>> keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
>>>> net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
>>>> channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
>>>> qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
>>>> vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
>>>> dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25
>>>>
>>>> Signed-off-by: Navid Emamdoost <navidem@google.com>
>>>
>>> Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
>>>
>>>> ---
>>>>   tests/qtest/fuzz/generic_fuzz_configs.h | 50 +++++++++++++++++++++++++
>>>>   1 file changed, 50 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
>>>> index ef0ad95712..9c46e106a4 100644
>>>> --- a/tests/qtest/fuzz/generic_fuzz_configs.h
>>>> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
>>>> @@ -29,6 +29,52 @@ static inline gchar *generic_fuzzer_virtio_9p_args(void){
>>>>       "writeout=immediate,fmode=0600,dmode=0700", tmpdir);
>>>>   }
>>>>
>>>> +/*
>>>> + * Global variables and cleanup handler for VNC fuzzer sockets.
>>>> + * These are needed because the socket paths must be available at exit.
>>>> + */
>>>> +static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
>>>> +static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
>>>> +
>>>> +static void cleanup_vnc_sockets(void)
>>>> +{
>>>> +    if (g_vnc_socket_path[0] != '\0') {
>>>> +        unlink(g_vnc_socket_path);
>>>> +    }
>>>> +    if (g_vnc_ws_socket_path[0] != '\0') {
>>>> +        unlink(g_vnc_ws_socket_path);
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * Dynamically generate VNC arguments with unique unix socket paths.
>>>> + * This allows multiple fuzzing jobs to run in parallel without conflict.
>>>> + */
>>>> +static inline gchar *generic_fuzzer_vnc_args(void)
>>>> +{
>>>> +    static bool cleanup_registered = false;
>>>> +    int fd;
>>>> +
>>>> +    strcpy(g_vnc_socket_path, "/tmp/qemu-vnc.XXXXXX");
>>>> +    fd = g_mkstemp(g_vnc_socket_path);
>>>> +    g_assert_cmpint(fd, !=, -1);
>>>> +    close(fd);
>>>> +
>>>> +    strcpy(g_vnc_ws_socket_path, "/tmp/qemu-vnc-ws.XXXXXX");
>>>> +    fd = g_mkstemp(g_vnc_ws_socket_path);
>>>> +    g_assert_cmpint(fd, !=, -1);
>>>> +    close(fd);
>>>> +
>>>> +    if (!cleanup_registered) {
>>>> +        atexit(cleanup_vnc_sockets);
>>>> +        cleanup_registered = true;
>>>> +    }
>>>> +
>>>> +    return g_strdup_printf("-machine q35 -nodefaults "
>>>> +                           "-vnc vnc=unix:%s,websocket=unix:%s",
>>>> +                           g_vnc_socket_path, g_vnc_ws_socket_path);
>>>> +}
>>>> +
>>>>   const generic_fuzz_config predefined_configs[] = {
>>>>       {
>>>>           .name = "virtio-net-pci-slirp",
>>>> @@ -247,6 +293,10 @@ const generic_fuzz_config predefined_configs[] = {
>>>>           .args = "-machine q35 -nodefaults "
>>>>           "-parallel file:/dev/null",
>>>>           .objects = "parallel*",
>>>> +    },{
>>>> +        .name = "vnc",
>>>> +        .argfunc = generic_fuzzer_vnc_args,
>>>> +        .objects = "*",
>>>>       }
>>>>   };
>>>>
>>>> --
>>>> 2.51.2.1041.gc1ab5b90ca-goog
>>>>
>>>>
>>>
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
>> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
>> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
>>
> 


