Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59A8C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5JH0-0007se-7m; Fri, 10 May 2024 01:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JGw-0007sD-1t
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5JGu-00075o-Fs
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715320700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TmobtV4J2Dk2L4n/lAtY8xVi7DkDAEPDO4VvjsDAUyo=;
 b=ZkDeacA+l8F8DNOw2H/IYa7dFJ3oiYYkDETjTUMVncuhqCXlRPLLTBmoJw/r3QDW24rAmv
 yj9JsJmWEer9HpnRS2thaGnrx8Bho9YZDwXypL8TDMcphY7sf5HVT6++CZNdd35UbAgefv
 CY72aKf7y/MCR0ogSXWeRkCHb/pw7/w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-MQySsNz3MIe9YLRZ8Bv-fA-1; Fri, 10 May 2024 01:58:14 -0400
X-MC-Unique: MQySsNz3MIe9YLRZ8Bv-fA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59c3cf5f83so97416266b.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 22:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715320693; x=1715925493;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TmobtV4J2Dk2L4n/lAtY8xVi7DkDAEPDO4VvjsDAUyo=;
 b=rzOITuk3jKjM3AK9PydXWt2/IOL25ZspJi0UaFeke6+ntb/J58lsGIUgKQ8UosKNws
 QubWFxJPC/kAsZgCmc2cpjzvSwNaQybfh/GGtdDZCtIrhjwa/8lYaSaKmBhe94zBSZq6
 hjOkBTr38pGAXY+3yhuk17Aa9Aze2rC8xGwsESRhbhzzTAcq4JFh4Bmogf8ezNVJuksf
 1FL37A9OYkhzK2I/mSRVopVc0FGH7anUo1VtxDBKrkeZfYHZ/+uVbujL6hinIiPoIHL0
 Fnx7xeU7zXUchNgysdd96ra/dOhp+joz7lOnIMdrV15esdW1y1ZHEXokREucObmI+MNM
 czuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzyxNQ9+czPz5ihsFGEXenKK8RkSSyXn70nTXodPV6o83gjMXiYv+BWdrl4OaoeQkxN/iSil2kNJcpfZ55IPrlgH5rGK8=
X-Gm-Message-State: AOJu0YyvFOSHePzd51TVTsZP0dfI8vyAyFg0fWIEp6AEJlRidEv23v2x
 9XuGvW9snnlY1Z+yP9Q8I8h3GKTQjdfpnwoGlOoMLmXIB0HFrcE4utKScxDuJ3rxn7GKpiCA62b
 +UcJwF890A94zVLxa6ILqjSVzTrY2hozQcK8sTz+JhZw9JgP+LGzs
X-Received: by 2002:a17:906:da8b:b0:a59:bdb7:73f8 with SMTP id
 a640c23a62f3a-a5a2d66a3b4mr134177966b.47.1715320693572; 
 Thu, 09 May 2024 22:58:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMO6pvHgTBYmlat13I9Ovfu4O0k1dlYWHEbSnvYsPGjg+mKh0tYAtraE6XQYs/oW3IDVs1cQ==
X-Received: by 2002:a17:906:da8b:b0:a59:bdb7:73f8 with SMTP id
 a640c23a62f3a-a5a2d66a3b4mr134174866b.47.1715320693241; 
 Thu, 09 May 2024 22:58:13 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c823dsm147513866b.100.2024.05.09.22.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 22:58:12 -0700 (PDT)
Message-ID: <18a2283a-468e-4e36-ae3c-6b2a65f2bbff@redhat.com>
Date: Fri, 10 May 2024 07:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] tests/qtest/vhost-user-test: add a test case for
 memory-backend-shm
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-13-sgarzare@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20240508074457.12367-13-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/05/2024 09.44, Stefano Garzarella wrote:
> `memory-backend-shm` can be used with vhost-user devices, so let's
> add a new test case for it.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   tests/qtest/vhost-user-test.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index d4e437265f..8c1d903b2a 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -44,6 +44,8 @@
>                           "mem-path=%s,share=on -numa node,memdev=mem"
>   #define QEMU_CMD_MEMFD  " -m %d -object memory-backend-memfd,id=mem,size=%dM," \
>                           " -numa node,memdev=mem"
> +#define QEMU_CMD_SHM    " -m %d -object memory-backend-shm,id=mem,size=%dM," \
> +                        " -numa node,memdev=mem"
>   #define QEMU_CMD_CHR    " -chardev socket,id=%s,path=%s%s"
>   #define QEMU_CMD_NETDEV " -netdev vhost-user,id=hs0,chardev=%s,vhostforce=on"
>   
> @@ -195,6 +197,7 @@ enum test_memfd {
>       TEST_MEMFD_AUTO,
>       TEST_MEMFD_YES,
>       TEST_MEMFD_NO,
> +    TEST_MEMFD_SHM,
>   };
>   
>   static void append_vhost_net_opts(TestServer *s, GString *cmd_line,
> @@ -228,6 +231,8 @@ static void append_mem_opts(TestServer *server, GString *cmd_line,
>   
>       if (memfd == TEST_MEMFD_YES) {
>           g_string_append_printf(cmd_line, QEMU_CMD_MEMFD, size, size);
> +    } else if (memfd == TEST_MEMFD_SHM) {
> +        g_string_append_printf(cmd_line, QEMU_CMD_SHM, size, size);
>       } else {
>           const char *root = init_hugepagefs() ? : server->tmpfs;
>   
> @@ -788,6 +793,19 @@ static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
>       return server;
>   }
>   
> +static void *vhost_user_test_setup_shm(GString *cmd_line, void *arg)
> +{
> +    TestServer *server = test_server_new("vhost-user-test", arg);
> +    test_server_listen(server);
> +
> +    append_mem_opts(server, cmd_line, 256, TEST_MEMFD_SHM);
> +    server->vu_ops->append_opts(server, cmd_line, "");
> +
> +    g_test_queue_destroy(vhost_user_test_cleanup, server);
> +
> +    return server;
> +}
> +
>   static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
>   {
>       TestServer *server = arg;
> @@ -1081,6 +1099,11 @@ static void register_vhost_user_test(void)
>                    "virtio-net",
>                    test_read_guest_mem, &opts);
>   
> +    opts.before = vhost_user_test_setup_shm;
> +    qos_add_test("vhost-user/read-guest-mem/shm",
> +                 "virtio-net",
> +                 test_read_guest_mem, &opts);
> +
>       if (qemu_memfd_check(MFD_ALLOW_SEALING)) {
>           opts.before = vhost_user_test_setup_memfd;
>           qos_add_test("vhost-user/read-guest-mem/memfd",

Acked-by: Thomas Huth <thuth@redhat.com>


