Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F67CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAsrh-000438-Ib; Mon, 20 Oct 2025 12:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAsrg-00042r-21
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vAsre-00038C-7o
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 12:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760978165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/uS3Nr0pVoYk/nSmO3dKivLzUIJUmtSM8Zqrm+3Idnw=;
 b=CoGW3SAz50qNEvbat2RnqErzH0wFudccZo1keIMzY+3xUgnOcVNaM5PPKfTKEei9lGj1rF
 kJKtbzsh1RERyCQRdMfHYF2Ztt+wejWvtp4KkFrECWYZ9O82ZRDH7ENUZXaIgWEw6YRfbp
 RVzbfRDMCxIZrmOtp9L7srnmyrME7Dg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-6cJAWzsHOZ2hUaVuZWydSA-1; Mon, 20 Oct 2025 12:36:03 -0400
X-MC-Unique: 6cJAWzsHOZ2hUaVuZWydSA-1
X-Mimecast-MFC-AGG-ID: 6cJAWzsHOZ2hUaVuZWydSA_1760978162
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-426ede1d66fso2482345f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 09:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760978162; x=1761582962;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uS3Nr0pVoYk/nSmO3dKivLzUIJUmtSM8Zqrm+3Idnw=;
 b=qISuH8ZLdrrFRol8xqLIloLfyCJ+VDGnVpQDugzEu82e6cUZfNBpZSnGq9eUSOoH5F
 h2WwVa6pAHQUB+rNOyRjTPCVIJCYEDcpUR1UcqOggRFdxfl351zrRRf6UPanmmBbhGJ5
 +eMR1evsY5KhQjpXZO74xGBO6OdvgtoQSTUHFySqHL0cO5WYRsxHryn60aqLGy9ydgJ+
 kw1EQL+U1vsxtz++QKzDlkoDxDtLuMqoAJWah+T4xRqFDFD8lJ/UXvu2L9q2Z7kqxMh4
 vR54BaeAZbRdIQtGwP52yTvWQ8o3FZJhaAYwytnqQz0jPJPtyvClrF24RrQTEa6Kbiq7
 KRYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqfDrWFboTzZqlM2swKr0/1QirIo5Fq388KCb5RxZuymtjrV/YymgZ7c3wABtVbQS3znA+tXerBtiH@nongnu.org
X-Gm-Message-State: AOJu0YxwQ67YRb5+v6oaM9J2ZRDJY1GQFzHIC9m7LmoG8rN8EAUizBrV
 ar8N/WDyttwRJZccKaBLKXqlnGh0ZLB0DLPEYiqVKIIvwUEEtmO3xHE3LJl1gKoEMs6U3yghnzY
 FGfyllx3Deu3UVBqaeG2ybJuFPqpFiofUjMWFmgtK7Cntjw2sAEQQR+/O
X-Gm-Gg: ASbGncucXGuFWjg3d+j+r2FryyiJyvyYw5VkQHXOsQdLvMrlkikxEK/Ve2ji1T469Tl
 ViKZ+rmEL+5Kv72OuaPGVOt6FPck09hxrc4tFko9+V2COAZwZJsk9UhJ1A4JyWf0ayoxDQEaYOi
 DiLoWK+praTY0ER8rjsZVmPrvkYamJo9QNcyUF1cy1NxQquDa6sbcTCcRPDqC9RK4suHe61ZhRb
 mAsT+GV8z8iIowS9svWQ6U2NBeCivWTVrw28umN6Yq7USuAAPql1uziEmmkQo/CcLHIH6jpMT8l
 7PNhCFVEb2r6yK85IzFZfz1CHHzXvrgdUEUmPq2xAAnMd0IaDWvtqcdOEIrQsORpFSuxssdxz1d
 fJJreL6EC3u8UZbLZzYU2mJ+CpXk8atxtdlht286+
X-Received: by 2002:a05:6000:186a:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-42704d1432amr9328646f8f.12.1760978162170; 
 Mon, 20 Oct 2025 09:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKEezxILXOIncfeg7e6TtE7ZZKOR0ELQGxjc7o9Cn7xgFpRSTwqjRJFiXwp7ekFQ5xpP16g==
X-Received: by 2002:a05:6000:186a:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-42704d1432amr9328620f8f.12.1760978161748; 
 Mon, 20 Oct 2025 09:36:01 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471529598c9sm150931485e9.5.2025.10.20.09.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 09:36:01 -0700 (PDT)
Message-ID: <f9b08344-46e7-492a-b83f-c3593a800b1e@redhat.com>
Date: Mon, 20 Oct 2025 18:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] tests/functional: add tests for SCLP event CPI
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
References: <20251016121708.334133-1-shalini@linux.ibm.com>
 <20251016121708.334133-2-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251016121708.334133-2-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 16/10/2025 14.17, Shalini Chellathurai Saroja wrote:
> Add tests for SCLP event type Control-Program Identification.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/s390x/test_ccw_virtio.py | 26 +++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
> index 453711aa0f..0455337856 100755
> --- a/tests/functional/s390x/test_ccw_virtio.py
> +++ b/tests/functional/s390x/test_ccw_virtio.py
> @@ -15,6 +15,7 @@
>   import tempfile
>   
>   from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command
>   from qemu_test import exec_command_and_wait_for_pattern
>   from qemu_test import wait_for_console_pattern
>   
> @@ -270,5 +271,30 @@ def test_s390x_fedora(self):
>                           'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
>                           ' sleep 1 ; done', 'Start virtcrypto_remove.')
>   
> +        # Test SCLP event Control-Program Identification (CPI)
> +        cpi = '/sys/firmware/cpi/'
> +        sclpcpi = '/machine/sclp/s390-sclp-event-facility/sclpcpi'
> +        self.log.info("Test SCLP event CPI")
> +        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
> +        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
> +        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
> +        exec_command(self, 'echo 0x001a000000060b00 > ' + cpi + 'system_level')
> +        exec_command_and_wait_for_pattern(self,
> +                                          'echo 1 > ' + cpi + 'set', ':/#')
> +        try:
> +            event = self.vm.event_wait('SCLP_CPI_INFO_AVAILABLE')
> +        except TimeoutError:
> +            self.fail('Timed out waiting for the SCLP_CPI_INFO_AVAILABLE event')
> +        ts = self.vm.cmd('qom-get', path=sclpcpi, property='timestamp')
> +        self.assertNotEqual(ts, 0)
> +        name = self.vm.cmd('qom-get', path=sclpcpi, property='system_name')
> +        self.assertEqual(name.strip(), 'TESTVM')
> +        typ = self.vm.cmd('qom-get', path=sclpcpi, property='system_type')
> +        self.assertEqual(typ.strip(), 'LINUX')
> +        sysplex = self.vm.cmd('qom-get', path=sclpcpi, property='sysplex_name')
> +        self.assertEqual(sysplex.strip(), 'TESTPLEX')
> +        level = self.vm.cmd('qom-get', path=sclpcpi, property='system_level')
> +        self.assertEqual(level, 0x001a000000060b00)
> +
>   if __name__ == '__main__':
>       QemuSystemTest.main()

Reviewed-by: Thomas Huth <thuth@redhat.com>


