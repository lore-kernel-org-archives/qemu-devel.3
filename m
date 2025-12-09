Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FCCD3B983
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0jv-0006rn-3n; Tue, 09 Dec 2025 11:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vT0jt-0006rK-Om
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:39:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vT0js-0005a9-6D
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765298338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wX4nK9oEPmvI1o3tmJUbsj2CRS3n5oVh67jnrcb3TP4=;
 b=X1upm3UROG+VnQmYmPhFbFUeAcFx6AAOh1dgvOoKTpuXc5RGKUAcnZunMRHNYYqssgAjRt
 1LYqfBcQNi6LNE9oGUgFEJFyGghvHGoSEWcMDwlwbWTNbRYxQRM2kmHt7FtytuzfUAAXRL
 Xob8rz8r8ECFDLHM34KCWOBqPd30JRI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-OGGALlVfPMetXHz0YDsTUA-1; Tue, 09 Dec 2025 11:38:57 -0500
X-MC-Unique: OGGALlVfPMetXHz0YDsTUA-1
X-Mimecast-MFC-AGG-ID: OGGALlVfPMetXHz0YDsTUA_1765298336
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so59100685e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765298335; x=1765903135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wX4nK9oEPmvI1o3tmJUbsj2CRS3n5oVh67jnrcb3TP4=;
 b=Ay4+RnMZe28mp1dnaOX3ilan4BC8O4lNimvxQUa/Z9Y4Ckw6cepQWzaapskmUIx/sh
 Hy0WTePO8kuH4q0Ihaxt5J6xHRFMRDAbrMBSK96/yGlE6yLWxKRsQOnNGnpk8AslmG6V
 DOz8uJ8TMcigUxUZ7rh1S5UMOqLfAaVhr7jK7+ZHdpWgwbz+f3qNNXc5tlQ/Hq2O/8aC
 6XIE+CllEF7mRrida0q8DnrLW+AfMJQpwtR5uB8ktjj1Boj+YK+2CJIpn/iG/xGsq6df
 iI0/7y3QASx3XQJENH8ZnC83len96dfPQcV13KiAoQovqCCPIWSZLxgyD8MTHnwuPEx0
 sTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765298335; x=1765903135;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wX4nK9oEPmvI1o3tmJUbsj2CRS3n5oVh67jnrcb3TP4=;
 b=rCz+JhU5EkHzSllukpMQrQR61261eRu+ZguvCr+3bzusDFXGQxwuiyCGjte2u2QZ5o
 nF3gni2qJZ68L8YWCyZKtaYwI7vxihlKo8YMKw1ASeh0D1KpNTYoeplzsyzCiqcXAnrB
 NoEEF8eLrMYYtBfD6HfK/U7digbA8MGEVB8FYmlKh91kH07HDgcFhHqZMKZ/nFSHCY4k
 SoqmeZDBKJnR4JFVZ9TqMYDhD7f5XQSCLUvWMfPeLreVjuF0Asj29b5zqHIdK418O72k
 Ew94Xm2TyvptHM2MgWjRwXimq2BFSBiTG0XqFfAtD/kQciwRmkf8CCCxTv56c4SSUeHz
 QbCg==
X-Gm-Message-State: AOJu0YwcIpY5R/cjbOgZAUC9DwcDSi92RtIQ8gF0clvPCWnVPzRj8rBN
 9n6ocP814ndqzKIfFJA8uSpnRnQ69AdSYM2h4XI7Tm5M2qJJXz1jm5LVmto6H8b5urNv1+85lja
 entYYeQ9U6yY2IBTTHcfPpswvDJwYb7sKVSTcmpOlnkIggeKFLwiHfHoPoVbBYDf1e/ME5jP0Ge
 yyvkMuZuyu4nncrwv8bfRO2OkcjhYNYgVaxg==
X-Gm-Gg: ASbGncsIWfMgW+gx+2nRmW7xGTnI+Fz+9O46zMVIz1vHq6Y+V9k0V+4fZNxrJCjzyWs
 82rARjX9W/cAZ8M+5Kf7qram6HIDS5yGVvv1Ym97okCamBBR9LtVUNJqT69Aj2VMARCHsyqJZ4e
 o1SxXXaULxeqRqrDz5M81TgcmxakhWEjdwqAakn3tq6NlTNYtFTvcjwYrFjPj3c7yQUPkYgbPXe
 BspTa5Ik/NXTQPC0djXqbE9KbYpZh3yW8p97qZML5d9HnXKqfLucSlRXjGg+yt/TUhZ2mmnMQCK
 dlEZ7B8Arc0EnublH5H/S3S7T5pjv8ohE33ppn5+t0FL1IZbcJtd/w7JJ+RWpi8e3XKJywQExfa
 bUtjjkVTKBmGI3YmIhzIGpfhp9sQfatficKC7UKx/o0IFsNup
X-Received: by 2002:a05:600c:354c:b0:479:3a87:2092 with SMTP id
 5b1f17b1804b1-4793a8720d4mr108586885e9.36.1765298335558; 
 Tue, 09 Dec 2025 08:38:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG72s/+wTKomZYbDwJ2qz7wwRxHkJfkY71uBg9iO/ODturRlzOhfzXh6DJm3Ng4DZ/zbcM5RQ==
X-Received: by 2002:a05:600c:354c:b0:479:3a87:2092 with SMTP id
 5b1f17b1804b1-4793a8720d4mr108586515e9.36.1765298334925; 
 Tue, 09 Dec 2025 08:38:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6fa121sm45508325e9.5.2025.12.09.08.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 08:38:54 -0800 (PST)
Message-ID: <3b34f492-874a-4ec6-b973-38f72c09a3f4@redhat.com>
Date: Tue, 9 Dec 2025 17:38:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] log: Fix result of strstr to 'const char *'
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
References: <20251209154128.661390-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251209154128.661390-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 12/9/25 16:41, Cédric Le Goater wrote:
> Assigning the result of strstr() to a 'char *' is unsafe since
> strstr() returns a pointer into the original string which is a
> read-only 'const char *' string.
> 
> A recent change in glibc 2.42.9000  :
> 
>     https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> breaks compiles, complaining the result of strstr() is not a
> 'const char *' :
> 
> ../util/log.c:208:24: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>    208 |         char *pidstr = strstr(filename, "%");
>        |                        ^~~~~~

There is much more to fix ... :/

../backends/tpm/tpm_passthrough.c: In function ‘tpm_passthrough_open_sysfs_cancel’:
../backends/tpm/tpm_passthrough.c:226:9: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   226 |     dev = strrchr(tpm_pt->tpm_dev, '/');
--
../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   749 |     char *p = strchr(buf, ':');
--
../ui/ui-hmp-cmds.c: In function ‘sendkey_completion’:
../ui/ui-hmp-cmds.c:427:9: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   427 |     sep = strrchr(str, '-');
--
../monitor/hmp.c: In function ‘key_get_info’:
../monitor/hmp.c:589:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   589 |     p = strchr(type, ':');
--
../qga/commands-linux.c: In function ‘build_guest_fsinfo_for_pci_dev’:
../qga/commands-linux.c:409:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   409 |     p = strstr(syspath, "/devices/pci");
       |       ^
../qga/commands-linux.c:440:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   440 |     p = strstr(syspath, "/target");
       |       ^
../qga/commands-linux.c:446:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   446 |     p = strstr(syspath, "/ata");
       |       ^
../qga/commands-linux.c:451:11: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   451 |         p = strstr(syspath, "/host");
--
../qga/commands-linux.c: In function ‘build_guest_fsinfo_for_nonpci_virtio’:
../qga/commands-linux.c:553:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   553 |     p = strstr(syspath, "/target");
--
../qga/commands-linux.c: In function ‘build_guest_fsinfo_for_ccw_dev’:
../qga/commands-linux.c:580:7: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   580 |     p = strstr(syspath, "/devices/css");
--
../gdbstub/gdbstub.c: In function ‘get_feature_xml’:
../gdbstub/gdbstub.c:365:18: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   365 |     char *term = strchr(p, ':');
--
../block/vmdk.c: In function ‘vmdk_parse_description’:
../block/vmdk.c:1095:13: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  1095 |     opt_pos = strstr(desc, opt_name);
--
../block/vvfat.c: In function ‘get_basename’:
../block/vvfat.c:1829:22: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  1829 |     char* basename = strrchr(path, '/');




